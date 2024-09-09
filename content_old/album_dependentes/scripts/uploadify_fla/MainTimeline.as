package uploadify_fla
{
    import com.adobe.serialization.json.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.utils.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var fileRefMulti:FileReferenceList;
        public var counter:Number;
        public var param:Object;
        public var fileQueue:Array;
        public var fileRefSingle:FileReference;
        public var allBytesTotal:Number;
        public var scriptURL:URLRequest;
        public var activeUploads:Object;
        public var fileItem:Object;
        public var filesChecked:Number;
        public var allowedTypes:Array;
        public var filesSelected:Number;
        public var allKbsAvg:Number;
        public var errorArray:Array;
        public var filesReplaced:Number;
        public var fileRefListener:Object;
        public var browseBtn:MovieClip;
        public var queueReversed:Boolean;
        public var allBytesLoaded:Number;
        public var variables:URLVariables;
        public var errors:Number;
        public var kbs:Number;
        public var filesUploaded:Number;

        public function MainTimeline()
        {
            addFrameScript(0, frame1);
            return;
        }// end function

        public function setButtonText() : void
        {
            if (param.buttonText)
            {
                browseBtn.empty.buttonText.text = unescape(param.buttonText);
            }// end if
            return;
        }// end function

        function frame1()
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            param = LoaderInfo(this.root.loaderInfo).parameters;
            fileRefSingle = new FileReference();
            fileRefMulti = new FileReferenceList();
            fileRefListener = new Object();
            fileQueue = new Array();
            fileItem = new Object();
            activeUploads = new Object();
            errorArray = new Array();
            counter = 0;
            filesSelected = 0;
            filesReplaced = 0;
            filesUploaded = 0;
            filesChecked = 0;
            errors = 0;
            kbs = 0;
            allBytesLoaded = 0;
            allBytesTotal = 0;
            allKbsAvg = 0;
            queueReversed = false;
            setButtonImg();
            setButtonText();
            browseBtn.buttonMode = true;
            browseBtn.useHandCursor = true;
            browseBtn.mouseChildren = false;
            setButtonSize();
            if (param.rollover)
            {
                browseBtn.addEventListener(MouseEvent.ROLL_OVER, 
function (param1:MouseEvent) : void
{
    param1.currentTarget.y = -param.height;
    return;
}// end function
);
                browseBtn.addEventListener(MouseEvent.ROLL_OUT, 
function (param1:MouseEvent) : void
{
    param1.currentTarget.y = 0;
    return;
}// end function
);
                browseBtn.addEventListener(MouseEvent.MOUSE_DOWN, 
function (param1:MouseEvent) : void
{
    param1.currentTarget.y = -param.height * 2;
    return;
}// end function
);
            }// end if
            if (!param.scriptData)
            {
                param.scriptData = "";
            }// end if
            setAllowedTypes();
            browseBtn.addEventListener(MouseEvent.CLICK, 
function () : void
{
    if (objSize(activeUploads) == 0)
    {
        if (!allowedTypes)
        {
            if (!param.multi)
            {
                fileRefSingle.browse();
            }
            else
            {
                fileRefMulti.browse();
            }// end else if
        }
        else if (!param.multi)
        {
            fileRefSingle.browse(allowedTypes);
        }
        else
        {
            fileRefMulti.browse(allowedTypes);
        }// end else if
    }// end else if
    return;
}// end function
);
            fileRefSingle.addEventListener(Event.SELECT, fileSelectSingleHandler);
            fileRefMulti.addEventListener(Event.SELECT, fileSelectMultiHandler);
            ExternalInterface.addCallback("updateSettings", uploadify_updateSettings);
            ExternalInterface.addCallback("startFileUpload", uploadify_uploadFiles);
            ExternalInterface.addCallback("cancelFileUpload", uploadify_cancelFileUpload);
            ExternalInterface.addCallback("clearFileUploadQueue", uploadify_clearFileUploadQueue);
            return;
        }// end function

        public function fileSelectMultiHandler(param1:Event) : void
        {
            var _loc_4:Object;
            var _loc_2:String;
            var _loc_3:Number;
            while (_loc_3++ < fileRefMulti.fileList.length)
            {
                // label
                fileItem = new Object();
                fileItem.file = fileRefMulti.fileList[_loc_3];
                _loc_4 = inQueue(fileRefMulti.fileList[_loc_3].name);
                if (_loc_4.testResult)
                {
                    allBytesTotal = allBytesTotal - _loc_4.size;
                    allBytesTotal = allBytesTotal + fileItem.file.size;
                    fileItem.ID = fileQueue[_loc_4.arrIndex].ID;
                    fileQueue[_loc_4.arrIndex] = fileItem;
                    filesReplaced++;
                    continue;
                }// end if
                if (fileQueue.length < param.queueSizeLimit)
                {
                    _loc_2 = generateID(6);
                    fileItem.ID = _loc_2;
                    fileQueue.push(fileItem);
                    filesSelected++;
                    allBytesTotal = allBytesTotal + fileItem.file.size;
                    $trigger("uploadifySelect", _loc_2, fileItem.file);
                    continue;
                }// end if
                $trigger("uploadifyQueueFull", param.queueSizeLimit);
                break;
            }// end while
            $trigger("uploadifySelectOnce", {fileCount:fileQueue.length, filesSelected:filesSelected, filesReplaced:filesReplaced, allBytesTotal:allBytesTotal});
            filesSelected = 0;
            filesReplaced = 0;
            if (param.auto)
            {
                if (param.checkScript)
                {
                    uploadify_uploadFiles(null, false);
                }
                else
                {
                    uploadify_uploadFiles(null, true);
                }// end if
            }// end else if
            return;
        }// end function

        public function uploadify_uploadFiles(param1:String, param2:Boolean) : void
        {
            var _loc_3:Object;
            var _loc_4:int;
            var _loc_5:Number;
            if (!queueReversed)
            {
                fileQueue.reverse();
                queueReversed = true;
            }// end if
            if (param.script.substr(0, 1) != "/" && param.script.substr(0, 4) != "http")
            {
                param.script = param.pagepath + param.script;
            }// end if
            scriptURL = new URLRequest(param.script);
            variables = new URLVariables();
            if (param.method.toUpperCase() == "GET")
            {
                scriptURL.method = URLRequestMethod.GET;
            }
            else
            {
                scriptURL.method = URLRequestMethod.POST;
            }// end else if
            if (param.scriptData != "")
            {
                variables.decode(unescape(param.scriptData));
            }// end if
            if (param.fileExt)
            {
                variables.fileext = unescape(param.fileExt);
            }// end if
            variables.folder = unescape(getFolderPath());
            scriptURL.data = variables;
            if (param.checkScript && !param2)
            {
                _loc_3 = new Object();
                if (param1)
                {
                    _loc_4 = getIndex(param1);
                    if (fileQueue[_loc_4].file)
                    {
                        _loc_3[fileQueue[_loc_4].ID] = fileQueue[_loc_4].file.name;
                    }// end if
                    $trigger("uploadifyCheckExist", param.checkScript, _loc_3, param.folder, true);
                }
                else
                {
                    while (_loc_5-- > -1)
                    {
                        // label
                        if (fileQueue[fileQueue.length--])
                        {
                            _loc_3[fileQueue[_loc_5].ID] = fileQueue[_loc_5].file.name;
                        }// end if
                    }// end while
                    $trigger("uploadifyCheckExist", param.checkScript, _loc_3, param.folder, false);
                }// end else if
            }
            else if (param1 && fileQueue[getIndex(param1)].file)
            {
                uploadFile(fileQueue[getIndex(param1)].file, getIndex(param1), param1, true);
            }
            else
            {
                while (_loc_5-- > -1)
                {
                    // label
                    if (objSize(activeUploads) < parseInt(param.simUploadLimit))
                    {
                        if (!activeUploads[fileQueue[fileQueue.length--].ID] && fileQueue[_loc_5].file)
                        {
                            uploadFile(fileQueue[_loc_5].file, _loc_5, fileQueue[_loc_5].ID, false);
                        }// end if
                        continue;
                    }// end if
                    break;
                }// end while
            }// end else if
            return;
        }// end function

        public function $trigger(param1:String, ... args) : void
        {
            var eventName:* = param1;
            var args:* = args;
            var p:* = 
function (param1:String) : String
{
    return "(" + param1 + ")";
}// end function
;
            var q:* = 
function (param1:String) : String
{
    return "\"" + param1 + "\"";
}// end function
;
            var list:Array;
            if (args.length > 0)
            {
                list.push(JSON.encode(args));
            }// end if
            ExternalInterface.call(["jQuery" + this.p(this.q("#" + param.uploadifyID)), this.p(list.join(","))].join(".trigger"));
            return;
        }// end function

        public function objSize(param1:Object) : Number
        {
            var _loc_3:*;
            var _loc_2:int;
            for (_loc_3 in param1)
            {
                // label
                _loc_2++;
            }// end of for ... in
            return _loc_2;
        }// end function

        public function hideButton(param1:Boolean) : void
        {
            if (param1)
            {
                browseBtn.empty.alpha = 0;
            }
            else
            {
                browseBtn.empty.alpha = 1;
            }// end else if
            return;
        }// end function

        public function getIndex(param1:String) : Number
        {
            var _loc_2:int;
            var _loc_3:Number;
            while (_loc_3++ < fileQueue.length)
            {
                // label
                if (fileQueue[_loc_3].ID == param1)
                {
                    _loc_2 = _loc_3;
                }// end if
            }// end while
            return _loc_2;
        }// end function

        public function uploadFile(param1:FileReference, param2:int, param3:String, param4:Boolean) : void
        {
            var startTimer:Number;
            var lastBytesLoaded:Number;
            var kbsAvg:Number;
            var fileOpenHandler:Function;
            var fileProgressHandler:Function;
            var fileCompleteHandler:Function;
            var file:* = param1;
            var index:* = param2;
            var ID:* = param3;
            var single:* = param4;
            fileOpenHandler = 
function (param1:Event)
{
    startTimer = getTimer();
    $trigger("uploadifyOpen", ID, param1.currentTarget);
    return;
}// end function
;
            fileProgressHandler = 
function (param1:ProgressEvent) : void
{
    var _loc_2:* = Math.round(param1.bytesLoaded / param1.bytesTotal * 100);
    if (getTimer() - startTimer >= 150)
    {
        kbs = (param1.bytesLoaded - lastBytesLoaded) / 1024 / ((getTimer() - startTimer) / 1000);
        kbs = int(kbs * 10) / 10;
        startTimer = getTimer();
        if (kbsAvg > 0)
        {
            kbsAvg = (kbsAvg + kbs) / 2;
        }
        else
        {
            kbsAvg = kbs;
        }// end else if
        allKbsAvg = (allKbsAvg + kbsAvg) / 2;
    }// end if
    allBytesLoaded = allBytesLoaded + (param1.bytesLoaded - lastBytesLoaded);
    lastBytesLoaded = param1.bytesLoaded;
    $trigger("uploadifyProgress", ID, param1.currentTarget, {percentage:_loc_2, bytesLoaded:param1.bytesLoaded, allBytesLoaded:allBytesLoaded, speed:kbs});
    return;
}// end function
;
            fileCompleteHandler = 
function (param1:DataEvent) : void
{
    if (kbsAvg == 0)
    {
        kbs = file.size / 1024 / ((getTimer() - startTimer) / 1000);
        kbsAvg = kbs;
        allKbsAvg = (allKbsAvg + kbsAvg) / 2;
    }// end if
    allBytesLoaded = allBytesLoaded - lastBytesLoaded;
    allBytesLoaded = allBytesLoaded + param1.currentTarget.size;
    $trigger("uploadifyProgress", ID, param1.currentTarget, {percentage:100, bytesLoaded:param1.currentTarget.size, allBytesLoaded:allBytesLoaded, speed:kbs});
    $trigger("uploadifyComplete", ID, {name:param1.currentTarget.name, filePath:getFolderPath() + "/" + param1.currentTarget.name, size:param1.currentTarget.size, creationDate:param1.currentTarget.creationDate, modificationDate:param1.currentTarget.modificationDate, type:param1.currentTarget.type}, escape(param1.data), {fileCount:fileQueue.length--, speed:kbsAvg});
    filesUploaded++;
    fileQueue.splice(getIndex(ID), 1);
    delete activeUploads[ID];
    if (!single)
    {
        uploadify_uploadFiles(null, true);
    }// end if
    param1.currentTarget.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, fileCompleteHandler);
    if (!fileQueue.some(queueIsNotEmpty) && objSize(activeUploads) == 0)
    {
        $trigger("uploadifyAllComplete", {filesUploaded:filesUploaded, errors:errors, allBytesLoaded:allBytesLoaded, speed:allKbsAvg});
        resetVars();
    }// end if
    return;
}// end function
;
            var resetVars:* = 
function ()
{
    filesUploaded = 0;
    errors = 0;
    allBytesLoaded = 0;
    allBytesTotal = 0;
    allKbsAvg = 0;
    filesChecked = 0;
    queueReversed = false;
    return;
}// end function
;
            var finishErrorHandler:* = 
function (param1:String)
{
    errorArray.push(param1);
    fileQueue[getIndex(param1)].file = "";
    delete activeUploads[param1];
    if (!single)
    {
        uploadify_uploadFiles(null, true);
    }// end if
    errors++;
    if (!fileQueue.some(queueIsNotEmpty))
    {
        if (root.hasEventListener(Event.ENTER_FRAME))
        {
            root.removeEventListener(Event.ENTER_FRAME, uploadCounter);
        }// end if
        $trigger("uploadifyAllComplete", {filesUploaded:filesUploaded, errors:errors, allBytesLoaded:allBytesLoaded, speed:allKbsAvg});
        resetVars();
    }// end if
    return;
}// end function
;
            startTimer;
            lastBytesLoaded;
            kbsAvg;
            file.addEventListener(Event.OPEN, fileOpenHandler);
            file.addEventListener(ProgressEvent.PROGRESS, fileProgressHandler);
            file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, fileCompleteHandler);
            file.addEventListener(HTTPStatusEvent.HTTP_STATUS, 
function (param1:HTTPStatusEvent) : void
{
    if (errorArray.indexOf(ID) == -1)
    {
        $trigger("uploadifyError", ID, param1.currentTarget, {type:"HTTP", info:param1.status});
        finishErrorHandler(ID);
    }// end if
    return;
}// end function
);
            file.addEventListener(IOErrorEvent.IO_ERROR, 
function (param1:IOErrorEvent) : void
{
    if (errorArray.indexOf(ID) == -1)
    {
        $trigger("uploadifyError", ID, param1.currentTarget, {type:"IO", info:param1.text});
        finishErrorHandler(ID);
    }// end if
    return;
}// end function
);
            file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, 
function (param1:SecurityErrorEvent) : void
{
    if (errorArray.indexOf(ID) == -1)
    {
        $trigger("uploadifyError", ID, param1.currentTarget, {type:"Security", info:param1.text});
        finishErrorHandler(ID);
    }// end if
    return;
}// end function
);
            if (param.sizeLimit && file.size > parseInt(param.sizeLimit))
            {
                if (errorArray.indexOf(ID) == -1)
                {
                    $trigger("uploadifyError", ID, file, {type:"File Size", info:param.sizeLimit});
                    this.finishErrorHandler(ID);
                }// end if
            }
            else
            {
                file.upload(scriptURL, param.fileDataName);
                activeUploads[ID] = true;
            }// end else if
            return;
        }// end function

        public function queueIsNotEmpty(param1, param2:int, param3:Array) : Boolean
        {
            return param1.file != "";
        }// end function

        public function getFolderPath() : String
        {
            var _loc_2:Array;
            var _loc_3:*;
            var _loc_1:* = param.folder;
            if (param.folder.substr(0, 1) != "/" && param.folder.substr(0, 4) != "http")
            {
                _loc_1 = param.pagepath + param.folder;
                _loc_2 = _loc_1.split("/");
                _loc_3 = 0;
                while (_loc_3++ < _loc_2.length)
                {
                    // label
                    if (_loc_2[_loc_3] == "..")
                    {
                        _loc_2.splice(_loc_3--, 2);
                    }// end if
                }// end while
                _loc_1 = _loc_2.join("/");
            }// end if
            return _loc_1;
        }// end function

        public function fileSelectSingleHandler(param1:Event) : void
        {
            fileItem = new Object();
            fileItem.file = FileReference(param1.target);
            uploadify_clearFileUploadQueue(true);
            var _loc_2:* = generateID(6);
            fileItem.ID = _loc_2;
            fileQueue.push(fileItem);
            filesSelected = 1;
            allBytesTotal = fileItem.file.size;
            $trigger("uploadifySelect", _loc_2, fileItem.file);
            $trigger("uploadifySelectOnce", {fileCount:fileQueue.length, filesSelected:filesSelected, filesReplaced:filesReplaced, allBytesTotal:allBytesTotal});
            filesSelected = 0;
            filesReplaced = 0;
            if (param.auto)
            {
                if (param.checkScript)
                {
                    uploadify_uploadFiles(null, false);
                }
                else
                {
                    uploadify_uploadFiles(null, true);
                }// end if
            }// end else if
            return;
        }// end function

        public function setAllowedTypes() : void
        {
            var _loc_1:Array;
            var _loc_2:Array;
            var _loc_3:*;
            allowedTypes = [];
            if (param.fileDesc && param.fileExt)
            {
                _loc_1 = param.fileDesc.split("|");
                _loc_2 = param.fileExt.split("|");
                _loc_3 = 0;
                while (_loc_3++ < _loc_1.length)
                {
                    // label
                    allowedTypes.push(new FileFilter(_loc_1[_loc_3], _loc_2[_loc_3]));
                }// end while
            }// end if
            return;
        }// end function

        public function uploadCounter(param1:Event) : void
        {
            counter++;
            return;
        }// end function

        public function uploadify_cancelFileUpload(param1:String, param2:Boolean, param3:Boolean) : void
        {
            var _loc_4:* = getIndex(param1);
            var _loc_5:* = new Object();
            if (fileQueue[_loc_4].file)
            {
                _loc_5 = fileQueue[_loc_4].file;
                fileQueue[_loc_4].file.cancel();
                allBytesTotal = allBytesTotal - fileQueue[_loc_4].file.size;
            }// end if
            fileQueue.splice(_loc_4, 1);
            if (activeUploads[param1])
            {
                delete activeUploads[param1];
                uploadify_uploadFiles(null, true);
                if (root.hasEventListener(Event.ENTER_FRAME) && objSize(activeUploads) == 0)
                {
                    root.removeEventListener(Event.ENTER_FRAME, uploadCounter);
                }// end if
            }// end if
            $trigger("uploadifyCancel", param1, _loc_5, {fileCount:fileQueue.length, allBytesTotal:allBytesTotal}, param3);
            return;
        }// end function

        public function generateID(param1:Number) : String
        {
            var _loc_4:Number;
            var _loc_2:Array;
            var _loc_3:String;
            var _loc_5:int;
            while (_loc_5 < param1)
            {
                // label
                _loc_3 = _loc_3 + _loc_2[Math.floor(Math.random() * 25)];
                _loc_5++;
            }// end while
            return _loc_3;
        }// end function

        public function uploadify_clearFileUploadQueue(param1:Boolean) : void
        {
            if (!queueReversed)
            {
                fileQueue.reverse();
                queueReversed = true;
            }// end if
            while (_loc_2-- >= 0)
            {
                // label
                uploadify_cancelFileUpload(fileQueue[fileQueue.length--].ID, false, param1);
            }// end while
            if (root.hasEventListener(Event.ENTER_FRAME))
            {
                root.removeEventListener(Event.ENTER_FRAME, uploadCounter);
            }// end if
            $trigger("uploadifyClearQueue");
            queueReversed = false;
            return;
        }// end function

        public function debug(param1)
        {
            ExternalInterface.call("alert(\"" + param1 + "\")");
            return;
        }// end function

        public function setButtonSize() : void
        {
            if (param.hideButton)
            {
                browseBtn.width = param.width;
                browseBtn.height = param.height;
            }// end if
            ExternalInterface.call("jQuery(\"#" + param.uploadifyID + "\").attr(\"width\"," + param.width + ")");
            ExternalInterface.call("jQuery(\"#" + param.uploadifyID + "\").attr(\"height\"," + param.height + ")");
            return;
        }// end function

        public function inQueue(param1:String) : Object
        {
            var _loc_3:*;
            var _loc_2:* = new Object();
            _loc_2.testResult = false;
            if (fileQueue.length > 0)
            {
                _loc_3 = 0;
                while (_loc_3++ < fileQueue.length)
                {
                    // label
                    if (fileQueue[_loc_3].file.name == param1)
                    {
                        _loc_2.size = fileQueue[_loc_3].file.size;
                        _loc_2.ID = fileQueue[_loc_3].ID;
                        _loc_2.arrIndex = _loc_3;
                        _loc_2.testResult = true;
                    }// end if
                }// end while
            }// end if
            return _loc_2;
        }// end function

        public function setButtonImg() : void
        {
            var _loc_1:Loader;
            var _loc_2:URLRequest;
            if (param.buttonImg)
            {
                _loc_1 = new Loader();
                _loc_2 = new URLRequest(param.buttonImg);
                browseBtn.addChild(_loc_1);
                _loc_1.load(_loc_2);
            }// end if
            if (!param.hideButton && !param.buttonImg)
            {
                browseBtn.empty.alpha = 1;
            }// end if
            return;
        }// end function

        public function uploadify_updateSettings(param1:String, param2)
        {
            if (param2 == null)
            {
                if (param1 == "queueSize")
                {
                    return fileQueue.length;
                }// end if
                return param[param1];
            }
            else
            {
                param[param1] = param2;
                if (param1 == "buttonImg")
                {
                    setButtonImg();
                }// end if
                if (param1 == "buttonText")
                {
                    setButtonText();
                }// end if
                if (param1 == "fileDesc" || param1 == "fileExt")
                {
                    setAllowedTypes();
                }// end if
                if (param1 == "width" || param1 == "height")
                {
                    setButtonSize();
                }// end if
                if (param1 == "hideButton")
                {
                    hideButton(param2);
                }// end if
                return true;
            }// end else if
        }// end function

    }
}
