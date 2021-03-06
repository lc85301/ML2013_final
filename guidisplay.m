function varargout = guidisplay(varargin)
% GUIDISPLAY MATLAB code for guidisplay.fig
%      GUIDISPLAY, by itself, creates a new GUIDISPLAY or raises the existing
%      singleton*.
%
%      H = GUIDISPLAY returns the handle to a new GUIDISPLAY or the handle to
%      the existing singleton*.
%
%      GUIDISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDISPLAY.M with the given input arguments.
%
%      GUIDISPLAY('Property','Value',...) creates a new GUIDISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guidisplay_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guidisplay_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guidisplay

% Last Modified by GUIDE v2.5 29-Dec-2013 14:05:01

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @guidisplay_OpeningFcn, ...
                       'gui_OutputFcn',  @guidisplay_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT
end


% --- Executes just before guidisplay is made visible.
function guidisplay_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guidisplay (see VARARGIN)

% Choose default command line output for guidisplay
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes guidisplay wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    global height width isTraining rawdataFName
    if(size(varargin,1)<1)
        isTraining=true;
    else
        isTraining=varargin{1};
    end
    GLOBALVAR;
    handles.label={'Mouse','Bull','Tiger','Rabbit','Dragon','Snake','Horse','Goat','Moncky','Chicken','Dog','Pig'};
    handles.degree=0;
    handles.fname=rawdataFName;
    handles.flipx=false;
    ibeg=1;
    iend=10;
    handles.imgIndBeg=ibeg;
    handles.imgIndEnd=iend;
    handles.imgh = height;
    handles.imgw = width;
    handles.only=-1;

    set(handles.imgIndBegTxt,'String',num2str(ibeg));
    set(handles.imgIndEndTxt,'String',num2str(iend));
    guidata(hObject,handles);
    readData(hObject, eventdata, handles);
end

% --- Outputs from this function are returned to the command line.
function varargout = guidisplay_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;
end

function imgIndText_Callback(hObject, eventdata, handles)
% hObject    handle to imgIndText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgIndText as text
%        str2double(get(hObject,'String')) returns contents of imgIndText as a double
end

% --- Executes during object creation, after setting all properties.
function imgIndText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgIndText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on slider movement.
function imgIndSlider_Callback(hObject, eventdata, handles)
% hObject    handle to imgIndSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    imgInd=floor(get(hObject,'value'));
    set(handles.imgIndText,'String',num2str(imgInd+handles.imgIndBeg-1));
    handles.degree=0;
    guidata(hObject,handles);
    showTextImg(handles,imgInd);
end


% --- Executes during object creation, after setting all properties.
function imgIndSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgIndSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end
end


% --- Executes on button press in turnRightBtn.
function turnRightBtn_Callback(hObject, eventdata, handles)
% hObject    handle to turnRightBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.degree=mod(handles.degree+1,4);
    guidata(hObject,handles);
    showTextImg(handles);
end

% --- Executes on button press in turnLeftBtn.
function turnLeftBtn_Callback(hObject, eventdata, handles)
% hObject    handle to turnLeftBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.degree=mod(handles.degree-1,4);
    guidata(hObject,handles);
    showTextImg(handles);
end


function imgIndBegTxt_Callback(hObject, eventdata, handles)
% hObject    handle to imgIndBegTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgIndBegTxt as text
%        str2double(get(hObject,'String')) returns contents of imgIndBegTxt as a double
end

% --- Executes during object creation, after setting all properties.
function imgIndBegTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgIndBegTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end



function imgIndEndTxt_Callback(hObject, eventdata, handles)
% hObject    handle to imgIndEndTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgIndEndTxt as text
%        str2double(get(hObject,'String')) returns contents of imgIndEndTxt as a double
end

% --- Executes during object creation, after setting all properties.
function imgIndEndTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgIndEndTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


% --- Executes on button press in reloadBtn.
function reloadBtn_Callback(hObject, eventdata, handles)
% hObject    handle to reloadBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.imgIndBeg=str2double(get(handles.imgIndBegTxt,'String'));
    handles.imgIndEnd=str2double(get(handles.imgIndEndTxt,'String'));
    guidata(hObject,handles);
    set(hObject,'Enable','off');
    readData(hObject, eventdata, handles);
    set(hObject,'Enable','on');
end

function readData(hObject, eventdata, handles)
    only=str2num(get(handles.onlyText,'String'));
    [handles.Y, handles.X]=guireadmatrix(handles.fname,handles.imgIndBeg,handles.imgIndEnd,only);
    guidata(hObject,handles);
    set(handles.imgIndSlider,'value',1);
    set(handles.imgIndText,'String',num2str(handles.imgIndBeg));
    set(handles.imgIndSlider,'Max',size(handles.Y,1));
    step=1/size(handles.Y,1);
    set(handles.imgIndSlider,'SliderStep',[step 5*step]);
    handles.degree=0;
    showTextImg(handles,num2str(handles.imgIndBeg));
end

function showTextImg(handles, imgInd)    
    %axis(handles.textImg);
    imgInd=str2double(get(handles.imgIndText,'String'));
    imgInd=imgInd-handles.imgIndBeg+1;
    img=handles.X(imgInd,:);     
    img=reshape(img,handles.imgw,handles.imgh);
    img=full(img);
    if(get(handles.normCheck,'Value'))
        img=normalizeImg(img);
    end
    a=handles.degree;
%     deg=handles.degree*90;
    deg=90;
%     img=imrotate(img,deg);
%     img=flipdim(img,1);
    
    imshow(img);
    if(handles.Y(imgInd)<1)
        set(handles.imgLabel,'String','?');
    else
        set(handles.imgLabel,'String',handles.label{handles.Y(imgInd)});
    end
end

% --- Executes on button press in normCheck.
function normCheck_Callback(hObject, eventdata, handles)
% hObject    handle to normCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normCheck
    showTextImg(handles);
end



function onlyText_Callback(hObject, eventdata, handles)
% hObject    handle to onlyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of onlyText as text
%        str2double(get(hObject,'String')) returns contents of onlyText as a double
end

% --- Executes during object creation, after setting all properties.
function onlyText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to onlyText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end
