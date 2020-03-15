% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
%grey = white/2;
% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black, [0 0 960 600]); 

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 110 110];

% Screen X positions of our three rectangles

startPhase = 0;
time = 0;


% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

f = [9,11,13,10,12,15];
phase = [0,0,0,0.5,0.4,0,25];
seq = nan(length(f),60);
for i = 1:length(f)
    seq(i,:) = sequence(f(i),phase(i));
end
seq = seq';
while ~KbCheck
    if time == 60
        time = 0;
    end
    allColors = repmat(seq(time+1,:),3,1);
    
    squareXpos = [screenXpixels * 0.2 screenXpixels * 0.5 screenXpixels * 0.8];
    squareXpos = repmat(squareXpos, 1, length(f)/length(squareXpos));
    y1 = screenYpixels * 0.3 * ones(1,3);
    y2 = screenYpixels * 0.5 * ones(1,3);
    y3 = screenYpixels * 0.7 * ones(1,3);
%     squareYpos = [y1 y2 y3];
    squareYpos = [y1 y3];
    numSqaures = length(squareXpos);
    
    allRects = nan(4, numSqaures);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
    end

    % Draw the rect to the screen
    Screen('FillRect', window, allColors, allRects);

    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    time = time+1;
end

% Clear the screen
sca;