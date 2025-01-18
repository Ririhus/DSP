
% Load the audio file
[audio, ws] = audioread('audioDSP.wav'); 
t = (0:length(audio)-1)/ws; % Time vector

% Plot the original signal in the time domain
figure;
plot(t, audio);
title('Original Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency domain analysis of the original signal
nfft = length(audio);
f = (0:nfft-1)*(ws/nfft); % Frequency vector
originalFFT = abs(fft(audio, nfft));

figure;
plot(f, originalFFT);
title('Original Signal Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Design IIR Butterworth filter
wc = 1000; % Cutoff frequency in Hz
filterOrder = 4; % Filter order (adjust based on your needs)
[b, a] = butter(filterOrder, wc/(ws/2), 'low'); 
% Low-pass Butterworth filter

% Plot the filter's frequency response
figure;
freqz(b, a, 1024, ws);
title('Frequency Response of IIR Butterworth Filter');

% Frequency response of 
% the IIR Butterworth filter
[H, w] = freqz(b, a, 1024, ws); 
% Compute frequency response

% Plot the magnitude response 
% in linear scale
figure;
plot(w, abs(H)); 
% Magnitude response
title(['Magnitude Response of IIR ' ...
    'Butterworth Filter (Linear Scale)']);
xlabel('Frequency (Hz)');
ylabel('|H(\omega)|');

% Apply the IIR Butterworth filter to the audio signal
filteredAudio = filter(b, a, audio);

% Plot the filtered signal in the time domain
figure;
plot(t, filteredAudio);
title('Filtered Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency domain analysis of the filtered signal
filteredFFT = abs(fft(filteredAudio, nfft));

figure;
plot(f, filteredFFT);
title('Filtered Signal Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Generate pole-zero plot 
% for the IIR Butterworth filter
figure;
zplane(b, a);
title(['Pole-Zero Plot of ' ...
    'IIR Butterworth Filter']);

% Plot the impulse response of the filter
figure;
impz(b, a);
title('Impulse Response of IIR Butterworth Filter');
xlabel('Samples');
ylabel('Amplitude');

% Save the filtered audio
audiowrite('filtered_audio_iir_butterworth.wav', filteredAudio, ws);

% Play the filtered audio
sound(filteredAudio, ws);

audiowrite('filtered_audio_iir_butterworth.wav', filteredAudio, ws);

% Get the current working directory
currentDirectory = pwd;

% Display the full path to the filtered audio file
filteredAudioPath = fullfile(currentDirectory, 'filtered_audio_iir_butterworth.wav');
disp(['Filtered audio file is saved at: ', filteredAudioPath]);
