##
## Copyright 2015 Ettus Research LLC
##
## Generate test data for use with Schmidl Cox testbench.
##
clc;
close all;
clear all;

# User variables
timing_error    = 0;     # Offset error
tx_freq         = 2.4e9; # Hz
freq_offset_ppm = 200;   # TCXO frequency offset in parts per million, typical value would be +/-20
gain            = 13;    # dB, Greater than 14 causes distortion on FFT output in test bench for unknown reasons
snr             = 25;    # dB

# Simulation variables (generally should not need to touch these)
tx_freq         = 2.4e9;
sample_rate     = 200e6;
cp_length       = 16;
symbol_length   = 64;

##### Generate test data
# From 802.11 specification
short_ts_f = sqrt(13/6)*[0,0,0,0,0,0,0,0,1+j,0,0,0,-1-j,0,0,0,1+j,0,0,0,-1-j,0,0,0,-1-j,0,0,0,1+j,0,0,0,0,0,0,0,-1-j,0,0,0,-1-j,0,0,0,1+j,0,0,0,1+j,0,0,0,1+j,0,0,0,1+j,0,0,0,0,0,0,0];
short_ts_f = ifftshift(short_ts_f);
short_ts_t = ifft(short_ts_f);
#12/52 carrier used + DC
long_ts_f = [1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 0 1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1];
ifft_data = [long_ts_f(27:end) 0 0 0 0 0 0 0 0 0 0 0 long_ts_f(1:26)];
long_ts_t = ifft(ifft_data);

short_preamble = zeros(1,160);
for i=1:10
  short_preamble(16*(i-1)+1:16*i) = short_ts_t(1:(64/4));
endfor
long_preamble = [long_ts_t(end-31:end) long_ts_t long_ts_t];

test_data = [zeros(1,128) short_preamble long_preamble];
preamble_offset = length(test_data);

for i=1:4096
  ramp(i) = i/(2^15);
end

test_data = [test_data long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t];
test_data = [test_data long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t];
test_data = [test_data long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t];
test_data = [test_data long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t];
test_data = [test_data long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t];
test_data = [test_data long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t];
test_data = [test_data short_preamble long_preamble];
test_data = [test_data long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t long_ts_t(end-15:end) long_ts_t];

# Add frequency offset
offset = ((freq_offset_ppm/1e6)*tx_freq)/sample_rate;
expected_phase_word = (2^13/64)*angle(exp(j*(63)*2*pi*offset))/pi;
printf("Expected phase word: %d (%f)\n",round(expected_phase_word),expected_phase_word);
test_data = add_freq_offset(test_data, offset);

# Add noise
test_data = awgn(test_data, snr);

# Add gain
test_data = test_data .* 10^(gain/20);

# Software based Schmidl Cox implementation for reference
[D, corr, pow, phase, trigger] = schmidl_cox(test_data, 64);

##### Plotting
figure;
subplot(1,2,1)
hold on;
title('Long preamble')
plot(real(fftshift(fft(test_data(preamble_offset+cp_length+timing_error+1:preamble_offset+cp_length+symbol_length+timing_error)))));
plot(imag(fftshift(fft(test_data(preamble_offset+cp_length+timing_error+1:preamble_offset+cp_length+symbol_length+timing_error)))),'r');

long_preamble = add_freq_offset(test_data(preamble_offset+cp_length+timing_error+1:preamble_offset+cp_length+symbol_length+timing_error),-phase(125)/(2*64)); # Correct for 2*pi & window len
subplot(1,2,2)
hold on;
title('Long preamble frequency corrected')
plot(real(fftshift(fft(long_preamble))));
plot(imag(fftshift(fft(long_preamble))),'r');

figure;
subplot(3,2,1:2);
hold on;
grid on;
plot(real(test_data));
plot(imag(test_data), 'r');
title('Time domain');
subplot(3,2,3);
plot(D(10:300),'k')
title('D')
subplot(3,2,4);
plot(abs(corr(1:300)));
title('Mag');
subplot(3,2,5)
plot(pow(1:300), 'r');
title('Power')
subplot(3,2,6)
plot(phase(1:300), 'b');
title('Angle')

##### Write to disk
# Convert to sc16
test_data_sc16 = zeros(1,2*length(test_data));
test_data_sc16(1:2:end-1) = int16((2^15).*real(test_data));
test_data_sc16(2:2:end) = int16((2^15).*imag(test_data));

# Complex float
test_data_cplx_float = zeros(1,2*length(test_data));
test_data_cplx_float(1:2:end-1) = real(test_data);
test_data_cplx_float(2:2:end) = imag(test_data); 

fileId = fopen('../test-sc16.bin', 'w');
fwrite(fileId, test_data_sc16, 'int16');
fclose(fileId);
fileId = fopen('test-float.bin', 'w');
fwrite(fileId, test_data_cplx_float, 'float');
fclose(fileId);
