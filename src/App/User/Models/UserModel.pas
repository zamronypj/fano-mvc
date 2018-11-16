(*!------------------------------------------------------------
 * Fano Framework Skeleton Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-app-views
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-app-views/blob/master/LICENSE (GPL 3.0)
 *------------------------------------------------------------- *)
unit UserModel;

interface

{$MODE OBJFPC}
{$H+}

uses

    fano,
    fpjson;

type

    (*!-----------------------------------------------
     * model that load data from static json file
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *------------------------------------------------*)
    TUserModel = class(TInterfacedObject, IModelReader, IDependency)
    private
        jsonData : TJSONData;
        jsonFilename : string;
    public
        constructor create(const jsonDataSrc : string);
        destructor destroy(); override;

        function read(const params : IModelWriteOnlyData = nil) : IModelReadOnlyData;
        function data() : IModelReadOnlyData;
    end;

implementation

uses

    Classes,
    SysUtils,
    jsonparser;

    constructor TUserModel.create(const jsonDataSrc : string);
    begin
        jsonData := nil;
        jsonFilename := jsonDataSrc;
    end;

    destructor TUserModel.destroy();
    begin
        inherited destroy();
        jsonData.free();
    end;

    function TUserModel.read(const params : IModelData) : IModelData;
    var fstr : TFileStream;
    begin
        fstr:= TFileStream.create(jsonFilename, fmOpenRead or fmShareDenyWrite);
        try
          jsonData := getJSON(fstr);
        finally
            fstr.free();
        end;
    end;
end.
