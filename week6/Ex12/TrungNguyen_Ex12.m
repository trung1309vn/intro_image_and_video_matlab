clear all;
close all;

% 1
% The noise threshold help reducing small movement estimation in current
% image block hence generalize the movement in region (neighborhood of
% block). The smaller threshold results in more noise, vice versa.

% 2
% When using the same noise threshold, original frame will produce more
% flow vector than frame that has already been filtered by wiener and
% diffusion. If we increase threshold too much, we won't have much info to
% observer, so perform filtering on image will help reduce number of
% optical flow vector while keeping the movement sensitivity.

opflow("echo2.avi", 0.0025, "");
opflow("echo2.avi", 0.0025, "wiener");
opflow("echo2.avi", 0.0025, "diffusion");

% Follow the result from the video. We can observe the clear movement of
% left vent wall from both side, with the opposite movement for each beat
% in "echo1", while in "echo2" we can only see the movement of the left
% side of the left vent wall. So, the heart in "echo1" is healthy and
% "echo2" is unhealthy

function opflow(video_path, noise_value, filter)
    % Constructs a multimedia reader object
    vidReader = VideoReader(video_path);
    % Initialize the optical flow object
    opticFlow = opticalFlowLK('NoiseThreshold', noise_value);
    while hasFrame(vidReader)
        % Read the rgb frame
        frameRGB  = readFrame(vidReader);
        % Convert rgb to grayscale
        frameGray = rgb2gray(frameRGB);
        filterFrame = frameGray;
        % Apply filter
        if (filter == "wiener")
            %fprintf("USE WIENER\n");
            filterFrame = wiener2(frameGray);
        elseif (filter == "diffusion")
            %fprintf("USE DIFFUSION\n");
            filterFrame = imdiffusefilt(frameGray);
        end
        % Compute optical flow
        flow = estimateFlow(opticFlow, filterFrame);
        % Display rgb video frame with flow vectorsd
        imshow(filterFrame);
        hold on;
        plot(flow, 'DecimationFactor', [5 5], 'ScaleFactor', 10, color='yellow');
        drawnow;
        hold off;
    end
end
















