unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls,Math;
const  VPI=3.14159265358979323846;
       LH0=0.0000000001;
       DEFAULT_MAX=VPI*2+0.1;
       DEFAULT_MIN=0;
       DEFAULT_DELTA=0.001;
       DEFAULT_LAMBDA=5.1;
       DEFAULT_PARAM=1;

       DEFAULT_WIDTH=640;
       DEFAULT_HEIGHT=480;

       DEFAULT_SCALE=40;
       DEFAULT_OFFSET=0;

type

TResultFunction=record
   x: real;
   y: real;
  end;

//---------------------------------------------------------------------------

TProduceFunction=class(TList)
private
      FMaxValue: real;
      FMinValue: real;
      FDelta: real;
      FFunctionValues: TList;

      function GetDelta: real;
      procedure SetDelta(AValue: real);
      procedure OnChangeValue;

      function IsValid(AValue: real): boolean;

      function GetMaxValue: real;
      procedure SetMaxValue(AValue: real);
      function GetMinValue: real;
      procedure SetMinValue(AValue: real);

      function GetFunctionValues: TList;
      function AddValue(Item:real): integer;
public
      procedure OnCalcValues; virtual;
      constructor Create(AMax,AMin,ADelta:real); overload;
      constructor Create; overload;
      destructor Destroy; override;
published
     property FunctionValues: TList read GetFunctionValues;
     property MaxValue: real read GetMaxValue write SetMaxValue;
     property MinValue: real read GetMinValue write SetMinValue;
     property Delta: real read GetDelta write SetDelta;
end;


//---------------------------------------------------------------------------

TProduceFunction81=class(TProduceFunction)
private
      FParam: real;
      procedure OnCalcValues; override;
      function GetParam: real;
      procedure SetParam(AValue: real);
public
      constructor Create(AParam,AMax,AMin,ADelta: real); overload;
      constructor Create; overload;
      destructor Destroy; override;
published
     property ParamFunction: real read GetParam write SetParam;
end;



//---------------------------------------------------------------------------

TFactoryScaler2d=class(TObject)
private
      FWidth,FHeight: integer;
      FPFunction: TList;
      FPoint: TPoint;
      FRfunc: TResultFunction;
      function GetWidth: integer;
      procedure SetWidth(AValue: integer);
      function GetHeight: integer;
      procedure SetHeight(AValue: integer);
      function GetCountFunctions: integer;
      function GetCountFunctionItems(Item: integer): integer;
      function GetPointFunction(findex,pindex: integer): TResultFunction;
      function GetPointFunctionScale(findex,pindex:integer): TPoint;

      function GetScaleFactor(fmin,fmax: double;SourceScal: integer): real;

protected
      FScaleP,FScaleM: real;
      pmin,pmax,mmin,mmax: real;
public
      function AddFunction(Item: TProduceFunction): integer;
      procedure ClearFunctions;
      procedure OnCalcScaler;
      constructor Create(AWidth,AHeight: integer); overload;
      property CountFunctionItems[Item: integer]: integer read GetCountFunctionItems;
      property PointFunction[findex,pindex: integer]: TResultFunction read GetPointFunction;
      property PointFunctionScale[findex,pindex: integer]: TPoint read GetPointFunctionScale;
      constructor Create; overload;
      destructor Destroy; override;
published
     property Width: integer read GetWidth write SetWidth;
     property Height: integer read GetHeight write SetHeight;
     property CountFunctions: integer read GetCountFunctions;
end;

//---------------------------------------------------------------------------

TGraficFunction2d=class(TFactoryScaler2d)
private
      FOffset: TPoint;
      FCanvas: TCanvas;
      FAxisXDiv,FAxisYDiv: integer;
      FPrecisionDiv: boolean;
      FTerminalDiv: boolean;
      function CalcZone: integer;
      procedure SetCanvas(AValue: TCanvas);
      function GetAxisXDiv: integer;
      procedure SetAxisXDiv(AValue: integer);
      function GetAxisYDiv: integer;
      procedure SetAxisYDiv(AValue: integer);

      function GetPrecisionDiv: boolean;
      procedure SetPrecisionDiv(AValue: boolean);
      function GetTerminalDiv: boolean;
      procedure SetTerminalDiv(AValue: boolean);


      procedure DrawAxisY(y1,y2,x: integer);
      procedure DrawDivAxisY(y1,y2,x: integer);
      procedure DrawDivAxisYTerm(x,precision: integer;AValue: real);
      procedure DrawAxisX(x1,x2,y: integer);
      procedure DrawDivAxisX(x1,x2,y: integer);
      procedure DrawDivAxisXTerm(y,precision: integer;AValue: real);
      procedure DrawDiv(x,y,precision: integer;DValue: real;AxisX: boolean);

      function GetPrecisionDivAxis(AValue: real): integer;
      function GetStepDivAxis(fmin,fmax: real; CntDiv: integer): real;
      function GetAxisCount(fmin,fmax: real; CntDiv: real): integer;
      function GetColorGrafik(i: integer): TColor;


public
      procedure UpdateGrafics;
      procedure DrawAxis;
      constructor Create(AOfsset: TPoint;AWidth,AHeight: integer); overload;
      constructor Create; overload;
      destructor Destroy; override;
published
     property Canvas: TCanvas write SetCanvas;
     property AxisXDiv: integer read GetAxisXDiv write SetAxisXDiv;
     property AxisYDiv: integer read GetAxisYDiv write SetAxisYDiv;
     property PrecisionDiv: boolean read GetPrecisionDiv write SetPrecisionDiv;
     property TerminalDiv: boolean read GetTerminalDiv write SetTerminalDiv;

end;
//---------------------------------------------------------------------------

  TForm1 = class(TForm)
    Image1: TImage;
    Chart1: TChart;
    Series1: TPointSeries;
    Series2: TPointSeries;
    Series3: TPointSeries;
    Series4: TPointSeries;
    Button3: TButton;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure Edit7Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
        pfr81_1: TProduceFunction81;
        pfr81_2: TProduceFunction81;
        pfr81_3: TProduceFunction81;
        pfr81_4: TProduceFunction81;
        sc81: TGraficFunction2d;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//===========================================================================
//===========================================================================

function TProduceFunction.IsValid(AValue: real): boolean;
begin
    if (AValue>=FMinValue) and (AValue<=FMaxValue) then result:=true
    else result:=false;
end;

//---------------------------------------------------------------------------
function TProduceFunction.GetMaxValue: real;
begin
    result:=FMaxValue;
end;

//---------------------------------------------------------------------------
function TProduceFunction.GetMinValue: real;
begin
    result:=FMinValue;
end;

//---------------------------------------------------------------------------
function TProduceFunction.AddValue(Item: real): integer;
var
    temp: ^real;
begin
    New(temp);
    temp^:=Item;
    if IsValid(Item) then result:=Add(temp)
    else Raise Exception.Create('???????? ? TVectorValues.AddValue ????? ???????????? ???????? !');
end;

//---------------------------------------------------------------------------
procedure TProduceFunction.SetMaxValue(AValue: real);
begin
    FMaxValue:=AValue;
    OnChangeValue;
end;

//---------------------------------------------------------------------------
procedure TProduceFunction.SetMinValue(AValue: real);
begin
    FMinValue:=AValue;
    OnChangeValue;
end;

//===========================================================================
//===========================================================================


procedure TProduceFunction.OnChangeValue;
var
   i,cnt: integer;
   l: real;
begin
   if Count<>0 then
   begin
     for i:=0 to Count-1 do Dispose(Items[i]);
     Clear;
   end;
   if Abs(FDelta)>LH0 then
   begin
     cnt:=Trunc(Abs(MaxValue-MinValue)/FDelta);
     l:=MinValue;
     for i:=0 to cnt do
     begin
         AddValue(l);
         l:=l+FDelta;
     end;
     OnCalcValues;
   end;
end;

//---------------------------------------------------------------------------

function TProduceFunction.GetDelta: real;
begin
    result:=FDelta;
end;

//---------------------------------------------------------------------------
procedure TProduceFunction.SetDelta(AValue: real);
begin
    if (AValue<0) Or (Abs(AValue)<LH0) then
    begin
       FDelta:=DEFAULT_DELTA;
       Raise Exception.Create('?????? ????? ???????????? ???????? !');
    end
    else FDelta:=AValue;
    OnChangeValue;
end;

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

function TProduceFunction.GetFunctionValues: TList;
begin
   result:=FFunctionValues;
end;

//---------------------------------------------------------------------------

procedure TProduceFunction.OnCalcValues;
begin

end;

//---------------------------------------------------------------------------

constructor TProduceFunction.Create(AMax,AMin,ADelta: real);
begin
  try
     FDelta:=ADelta;
     FMaxValue:=AMax;
     FMinValue:=AMin;
     FFunctionValues:=TList.Create;
     OnChangeValue;
  except
     Raise;
  end;
end;

//---------------------------------------------------------------------------
constructor TProduceFunction.Create;
begin
  inherited;
  try
     FMaxValue:=DEFAULT_MAX;
     FMinValue:=DEFAULT_MIN;
     FFunctionValues:=TList.Create;
     OnChangeValue;
  except
     Raise;
  end;
end;

//---------------------------------------------------------------------------
destructor TProduceFunction.Destroy;
var
   i: integer;
begin
   if Count<>0 then
   begin
     for i:=0 to Count-1 do Dispose(Items[i]);
     Clear;
   end;
   if FFunctionValues.Count<>0 then
   begin
     for i:=0 to FFunctionValues.Count-1 do Dispose(FFunctionValues.Items[i]);
     FFunctionValues.Clear;
   end;
   FFunctionValues.Free;
   inherited;
end;


//===========================================================================
//===========================================================================

procedure TProduceFunction81.SetParam(AValue: real);
begin
   if Abs(AValue)<=LH0 then
   begin
       FParam:=DEFAULT_PARAM;
       Raise Exception.Create('???????????? ???????? ????????? ? !');
   end
   else FParam:=AValue;
   OnCalcValues;
end;
//---------------------------------------------------------------------------
function TProduceFunction81.GetParam: real;
begin
    result:=FParam;
end;
//---------------------------------------------------------------------------

procedure TProduceFunction81.OnCalcValues;
var
  i: integer;
  PValue: ^real;
  r: real;
  temp: ^TResultFunction;
begin
  if FunctionValues<>NIL then
  begin
     if FunctionValues.Count<>0 then
     begin
       for i:=0 to FunctionValues.Count-1 do Dispose(FunctionValues.Items[i]);
       FunctionValues.Clear;
     end;
     for i:=0 to Count-1 do
     begin
       PValue:=Items[i];
       New(temp);
       r:=exp((-1)*((PValue^-FParam)*(PValue^-FParam)));
       temp.x:=r*cos(PValue^);
       temp.y:=r*sin(PValue^);
       FunctionValues.Add(temp);
     end;
  end;
end;
//---------------------------------------------------------------------------

constructor TProduceFunction81.Create(AParam,AMax,AMin,ADelta: real);
begin
  inherited Create(AMax,AMin,ADelta);
  try
     FParam:=AParam;
     OnCalcValues;
  except
     Raise;
  end;
end;

//---------------------------------------------------------------------------
constructor TProduceFunction81.Create;
begin
  inherited;
  try
     FParam:=DEFAULT_PARAM;
     OnCalcValues;
  except
     Raise;
  end;
end;
//---------------------------------------------------------------------------
destructor TProduceFunction81.Destroy;
begin
   inherited;
end;


//===========================================================================
//===========================================================================

function TFactoryScaler2d.GetWidth: integer;
begin
   result:=FWidth;
end;

//---------------------------------------------------------------------------

function TFactoryScaler2d.GetHeight: integer;
begin
   result:=FHeight;
end;

//---------------------------------------------------------------------------

procedure TFactoryScaler2d.SetWidth(AValue: integer);
begin
   if AValue>0 then FWidth:=AValue
   else
   begin
       FWidth:=DEFAULT_WIDTH;
       Raise Exception.Create('???????????? ???????? Width !');
   end;
   OnCalcScaler;
end;

//---------------------------------------------------------------------------

procedure TFactoryScaler2d.SetHeight(AValue: integer);
begin
   if AValue>0 then FHeight:=AValue
   else
   begin
       FHeight:=DEFAULT_HEIGHT;
       Raise Exception.Create('???????????? ???????? Height !');
   end;
   OnCalcScaler;
end;

//---------------------------------------------------------------------------
constructor TFactoryScaler2d.Create(AWidth,AHeight: integer);
begin
   FPFunction:=TList.Create;
   if AWidth>0 then FWidth:=AWidth
   else
   begin
       FWidth:=DEFAULT_WIDTH;
       Raise Exception.Create('???????????? ???????? Width !');
   end;
   if AHeight>0 then FHeight:=AHeight
   else
   begin
       FHeight:=DEFAULT_HEIGHT;
       Raise Exception.Create('???????????? ???????? Height !');
   end;
   OnCalcScaler;
end;

//---------------------------------------------------------------------------
constructor TFactoryScaler2d.Create;
begin
   inherited;
   FPFunction:=TList.Create;
   FWidth:=DEFAULT_WIDTH;
   FHeight:=DEFAULT_HEIGHT;
   OnCalcScaler;
end;
//---------------------------------------------------------------------------
destructor TFactoryScaler2d.Destroy;
begin
   FPFunction.Clear;
   OnCalcScaler;
   inherited;
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.AddFunction(Item: TProduceFunction): integer;
begin
   result:=FPFunction.Add(Item);
   OnCalcScaler;
end;

//---------------------------------------------------------------------------
procedure TFactoryScaler2d.ClearFunctions;
begin
    FPFunction.Clear;
    OnCalcScaler;
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetCountFunctions: integer;
begin
    result:=FPFunction.Count;
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetCountFunctionItems(Item: integer): integer;
var
  temp: TProduceFunction;
begin
   result:=-1;
   if (Item>=0) And (Item<FPFunction.Count) then
   begin
     temp:=FPFunction.Items[Item];
     result:=temp.Count;
   end
   else Raise Exception.Create('???????????? ???????? CountFunctionItems !');
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetPointFunction(findex,pindex: integer): TResultFunction;
var
  temp: TProduceFunction;
  gettemp: ^TResultFunction;
begin
   if (findex>=0) And (findex<FPFunction.Count) then
   begin
     temp:=FPFunction.Items[findex];
     if (pindex>=0) And (pindex<temp.FunctionValues.Count) then
     begin
       gettemp:=temp.FunctionValues.Items[pindex];
       FRfunc.x:=gettemp.x;
       FRfunc.y:=gettemp.y;
       result:=FRfunc;
     end
     else Raise Exception.Create('???????????? ???????? pindex ? GetPointFunction !');
   end
   else Raise Exception.Create('???????????? ???????? findex ? CountFunctionItems !');
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetPointFunctionScale(findex,pindex: integer): TPoint;
var
  temp: TProduceFunction;
  gettemp: ^TResultFunction;
begin
   if (findex>=0) And (findex<FPFunction.Count) then
   begin
     temp:=FPFunction.Items[findex];
     if (pindex>=0) And (pindex<temp.FunctionValues.Count) then
     begin
       gettemp:=temp.FunctionValues.Items[pindex];
       if pmin<0 then FPoint.x:=trunc(Abs(pmin*FScaleP))+trunc(gettemp.x*FScaleP)
       else FPoint.x:=trunc(gettemp.x*FScaleP);
       if mmin<0 then FPoint.y:=trunc(Abs(mmin*FScaleM))+trunc(gettemp.y*FScaleM)
       else FPoint.y:=trunc(gettemp.y*FScaleM);
       FPoint.y:=Height-FPoint.y;
       result:=FPoint;
     end
     else Raise Exception.Create('???????????? ???????? pindex ? GetPointFunction !');
   end
   else Raise Exception.Create('???????????? ???????? findex ? CountFunctionItems !');
end;

//---------------------------------------------------------------------------
function TFactoryScaler2d.GetScaleFactor(fmin,fmax: double;SourceScal: integer): real;
begin
      result:=1;
      if(Abs(fmax-fmin)>0) then
      begin
           if fmin>=0 then result:=SourceScal/fmax
           else
           begin
             if fmax<0 then result:=SourceScal/Abs(fmin)
             else result:=SourceScal/Abs(fmax-fmin);
           end;
      end;
end;

//---------------------------------------------------------------------------
procedure TFactoryScaler2d.OnCalcScaler;
var
   i,j: integer;
   temp: TProduceFunction;
   gettemp: ^TResultFunction;
begin
   pmin:=0;
   pmax:=0;
   mmin:=0;
   mmax:=0;
   if FPFunction.Count<>0 then
   begin
      for i:=0 to FPFunction.Count-1 do
      begin
            temp:=FPFunction.Items[i];
            for j:=0 to temp.FunctionValues.Count-1 do
            begin
               gettemp:=temp.FunctionValues.Items[j];
               if gettemp.x>pmax then pmax:=gettemp.x;
               if gettemp.x<pmin then pmin:=gettemp.x;
               if gettemp.y>mmax then mmax:=gettemp.y;
               if gettemp.y<mmin then mmin:=gettemp.y;
            end;
      end;
      FScaleP:=GetScaleFactor(pmin,pmax,FWidth);
      FScaleM:=GetScaleFactor(mmin,mmax,FHeight);
   end;
end;


//===========================================================================
//===========================================================================

procedure TGraficFunction2d.SetCanvas(AValue: TCanvas);
begin
   FCanvas:=AValue;
   UpdateGrafics;
end;

//---------------------------------------------------------------------------
constructor TGraficFunction2d.Create(AOfsset: TPoint;AWidth,AHeight: integer);
begin
     inherited Create(AWidth,AHeight);
     FPrecisionDiv:=true;
     FTerminalDiv:=true;
     FAxisYDiv:=5;
     FAxisXDiv:=5;
     FOffset:=AOfsset;
     UpdateGrafics;
end;

//---------------------------------------------------------------------------
constructor TGraficFunction2d.Create;
begin
     FOffset.x:=0;
     FOffset.y:=0;
     FPrecisionDiv:=true;
     FTerminalDiv:=true;
     FAxisYDiv:=5;
     FAxisXDiv:=5;
     UpdateGrafics;
end;

//---------------------------------------------------------------------------
destructor TGraficFunction2d.Destroy;
begin
   inherited;
end;
//---------------------------------------------------------------------------
function TGraficFunction2d.GetColorGrafik(i: integer): TColor;
begin
   case i of
   0: result:=clBlack;
   1: result:=clRed;
   2: result:=clGreen;
   3: result:=clBlue;
   end;
end;
//---------------------------------------------------------------------------
procedure TGraficFunction2d.UpdateGrafics;
var
   clr: TColor;
   i,j: integer;
   p: TPoint;
   p1: TResultFunction;
begin
   OnCalcScaler;
   if FCanvas<>NIL then
   begin
      FCanvas.FillRect(FCanvas.ClipRect);
      DrawAxis;
      if CountFunctions<>0 then
      begin
         for i:=0 to CountFunctions-1 do
         begin
            FCanvas.Pen.Color:=GetColorGrafik(i);
            for j:=0 to CountFunctionItems[i]-1 do
            begin
                  p:=PointFunctionScale[i,j];
                  FCanvas.Pen.Width:=1;
                  FCanvas.Ellipse(FOffset.x+p.x,FOffset.y+p.y,FOffset.x+p.x+2,FOffset.y+p.y+2);
                  p1:=PointFunction[i,j];
            end;
         end;
      end;
   end;

end;

//---------------------------------------------------------------------------
function TGraficFunction2d.CalcZone: integer;
begin
   if pmax<0 then
   begin
     if mmax<0 then result:=3
     else
     begin
       if mmin<0 then result:=7
       else result:=1;
     end
   end
   else
   begin
     if pmin<0 then
     begin
        if mmax<0 then result:=6
        else
        begin
           if mmin<0 then result:=9
           else result:=5;
        end;
     end
     else
     begin
        if mmax<0 then result:=4
        else
        begin
           if mmin<0 then result:=8
           else result:=2;
        end;
     end;
   end;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawAxis;
begin
    case CalcZone of
       1:
       begin
          DrawAxisY(0,Height,Width);
          DrawAxisX(0,Width,Height);
       end;
       2:
       begin
          DrawAxisY(0,Height,0);
          DrawAxisX(0,Width,Height);
       end;
       3:
       begin
          DrawAxisY(0,Height,Width);
          DrawAxisX(0,Width,0);
       end;
       4:
       begin
          DrawAxisY(0,Height,0);
          DrawAxisX(0,Width,0);
       end;
       5:
       begin
          DrawAxisY(0,Height,trunc(Abs(pmin*FScaleP)));
          DrawAxisX(0,Width,Height);
       end;
       6:
       begin
          DrawAxisY(0,Height,trunc(Abs(pmin*FScaleP)));
          DrawAxisX(0,Width,0);
       end;
       7:
       begin
          DrawAxisY(0,Height,Width);
          DrawAxisX(0,Width,Height-trunc(Abs(mmin*FScaleM)));
       end;
       8:
       begin
          DrawAxisY(0,Height,0);
          DrawAxisX(0,Width,Height-trunc(Abs(mmin*FScaleM)));
       end;
       9:
       begin
          DrawAxisY(0,Height,trunc(Abs(pmin*FScaleP)));
          DrawAxisX(0,Width,Height-trunc(Abs(mmin*FScaleM)));
       end;
     end;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawAxisY(y1,y2,x: integer);
begin
     FCanvas.Pen.Width:=1;
     FCanvas.MoveTo(FOffset.x+x,FOffset.y+y1);
     FCanvas.LineTo(FOffset.x+x,FOffset.y+y2);
     DrawDivAxisY(y1,y2,x);
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawAxisX(x1,x2,y: integer);
begin
     FCanvas.Pen.Width:=1;
     FCanvas.MoveTo(FOffset.x+x1,FOffset.y+y);
     FCanvas.LineTo(FOffset.x+x2,FOffset.y+y);
     DrawDivAxisX(x1,x2,y);
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetAxisXDiv: integer;
begin
   result:=FAxisXDiv;
end;
//---------------------------------------------------------------------------
procedure TGraficFunction2d.SetAxisXDiv(AValue: integer);
begin
    FAxisXDiv:=AValue;
    UpdateGrafics;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetAxisYDiv: integer;
begin
   result:=FAxisYDiv;
end;
//---------------------------------------------------------------------------
procedure TGraficFunction2d.SetAxisYDiv(AValue: integer);
begin
    FAxisYDiv:=AValue;
    UpdateGrafics;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetPrecisionDiv: boolean;
begin
   result:=FPrecisionDiv;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.SetPrecisionDiv(AValue: boolean);
begin
    FPrecisionDiv:=AValue;
    UpdateGrafics;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetTerminalDiv: boolean;
begin
   result:=FTerminalDiv;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.SetTerminalDiv(AValue: boolean);
begin
    FTerminalDiv:=AValue;
    UpdateGrafics;
end;


//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDiv(x,y,precision: integer;DValue: real;AxisX: boolean);
var
   fmt: String;
begin
        fmt:=FloatToStrF(DValue,ffFixed,4,precision);
        FCanvas.Font.Name:='Courier New';
        FCanvas.Font.Size:=6;
        if not AxisX then
        begin
           if Abs(pmax)>=Abs(pmin) then
           begin
             FCanvas.TextOut(FOffset.x+x+10,FOffset.y+y-10,fmt);
             FCanvas.MoveTo(FOffset.x+x,FOffset.y+y);
             FCanvas.LineTo(FOffset.x+x+5,FOffset.y+y);
           end
           else
           begin
             FCanvas.TextOut(FOffset.x+x-10-Length(fmt)*FCanvas.Font.Size,FOffset.y+y-10,fmt);
             FCanvas.MoveTo(FOffset.x+x-5,FOffset.y+y);
             FCanvas.LineTo(FOffset.x+x,FOffset.y+y);
           end
        end
        else
        begin
           if Abs(mmax)<=Abs(mmin) then
           begin
              FCanvas.TextOut(FOffset.x+x-10,FOffset.y+y+10,fmt);
              FCanvas.MoveTo(FOffset.x+x,FOffset.y+y);
              FCanvas.LineTo(FOffset.x+x,FOffset.y+y+5);
           end
           else
           begin
              FCanvas.TextOut(FOffset.x+x-10,FOffset.y+y-10-FCanvas.Font.Size,fmt);
              FCanvas.MoveTo(FOffset.x+x,FOffset.y+y-5);
              FCanvas.LineTo(FOffset.x+x,FOffset.y+y);
           end;
        end;
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDivAxisXTerm(y,precision: integer;AValue: real);
var
   temp: real;
begin
      if pmin<0 then temp:=Abs(pmin*FScaleP)+AValue*FScaleP
      else temp:=AValue*FScaleP;
      if (AValue>=pmin) And (AValue<=pmax) then DrawDiv(trunc(temp),y,precision,AValue,true);
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDivAxisYTerm(x,precision: integer;AValue: real);
var
     temp: real;
begin
     if mmin<0 then temp:=Abs(mmin*FScaleM)+AValue*FScaleM
     else temp:=AValue*FScaleM;
     temp:=Height-temp;
     if (AValue>=mmin) And (AValue<=mmax) then DrawDiv(x,trunc(temp),precision,AValue,false);
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetStepDivAxis(fmin,fmax: real; CntDiv: integer): real;
begin
   result:=0;
   if fmin>=0 then result:=fmax/CntDiv
   else
   begin
      if fmax<0 then result:=Abs(fmin/CntDiv)
      else result:=(fmax-fmin)/CntDiv;
   end;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetAxisCount(fmin,fmax: real; CntDiv: real): integer;
begin
   result:=0;
   if fmin>=0 then result:=round(fmax/CntDiv)
   else
   begin
      if fmax<0 then result:=round(Abs(fmin/CntDiv))
      else result:=round((fmax-fmin)/CntDiv);
   end;
end;

//---------------------------------------------------------------------------
function TGraficFunction2d.GetPrecisionDivAxis(AValue: real): integer;
var
    l: integer;
    res: real;
begin
     l:=0;
     res:=AValue;
     result:=0;
     while res<1 do
     begin
         res:=SimpleRoundTo(AValue,(-1)*l);
         res:=res*Power(10,l);
         l:=l+1;
     end;
     if l>0 then result:=l-1;
end;
//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDivAxisY(y1,y2,x: integer);
var
   mas : array of real;
   i,index,precision,axd: integer;
   minim,tmp,temp: real;
begin
   axd:=FAxisYDiv;
   temp:=GetStepDivAxis(mmin,mmax,FAxisYDiv);
   if not FPrecisionDiv then
   begin
      precision:=GetPrecisionDivAxis(temp);
      tmp:=SimpleRoundTo(temp,(-1)*precision);
      if tmp<temp then temp:=2*tmp
      else temp:=tmp;
      axd:=GetAxisCount(mmin,mmax,temp);
   end
   else precision:=2;
   SetLength(mas,axd);
   if(mmin>=0) then for i:=0 to axd-1 do mas[i]:=i*temp
   else
   begin
       if mmax<0 then for i:=0 to axd-1 do mas[i]:=i*temp
       else
       begin
          index:=trunc(mmin/temp);
          tmp:=index*temp;
          for i:=0 to axd-1 do mas[i]:=tmp+i*temp;
       end;
   end;

   for i:=0 to axd-1 do DrawDivAxisYTerm(x,precision,mas[i]);
   if FTerminalDiv then
   begin
     DrawDivAxisYTerm(x,precision,mmin);
     DrawDivAxisYTerm(x,precision,mmax);
   end;
   Finalize(mas);
end;

//---------------------------------------------------------------------------
procedure TGraficFunction2d.DrawDivAxisX(x1,x2,y: integer);
var
   mas : array of real;
   i,index,precision,axd: integer;
   minim,tmp,temp: real;
begin
  axd:=FAxisXDiv;
  temp:=GetStepDivAxis(pmin,pmax,FAxisXDiv);

  if not FPrecisionDiv then
   begin
      precision:=GetPrecisionDivAxis(temp);
      tmp:=SimpleRoundTo(temp,(-1)*precision);
      if tmp<temp then temp:=2*tmp
      else temp:=tmp;
      axd:=GetAxisCount(pmin,pmax,temp);
   end
   else precision:=2;
   SetLength(mas,axd);
   if pmin>=0 then for i:=0 to axd-1 do mas[i]:=i*temp
   else
   begin
       if pmax<0 then for i:=0 to axd-1 do mas[i]:=i*temp
       else
       begin
          index:=trunc(pmin/temp);
          tmp:=index*temp;
          for i:=0 to axd-1 do mas[i]:=tmp+i*temp;
       end;
   end;

   for i:=0 to axd-1 do DrawDivAxisXTerm(y,precision,mas[i]);
   if FTerminalDiv then
   begin
     DrawDivAxisXTerm(y,precision,pmin);
     DrawDivAxisXTerm(y,precision,pmax);
   end;
   Finalize(mas);
end;



//---------------------------------------------------------------------------


//---------------------------------------------------------------------------

procedure TForm1.Button3Click(Sender: TObject);
begin
   Button1.Enabled:=true;
   Edit1.Enabled:=true;
   Edit2.Enabled:=true;
   Edit3.Enabled:=true;
   Edit6.Enabled:=true;
   Edit7.Enabled:=true;
   CheckBox1.Enabled:=true;
   CheckBox2.Enabled:=true;
   Edit6.Text:=IntToStr(sc81.AxisXDiv);
   Edit7.Text:=IntToStr(sc81.AxisYDiv);
   CheckBox1.Checked:=sc81.PrecisionDiv;
   CheckBox2.Checked:=sc81.TerminalDiv;

   sc81.Canvas:=Image1.Canvas;
   sc81.UpdateGrafics;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
   i,j: integer;
   p1: TResultFunction;
begin
   for i:=0 to 3 do Chart1.Series[i].Clear;
   if sc81.CountFunctions<>0 then
   begin
      for i:=0 to sc81.CountFunctions-1 do
      begin
         for j:=0 to sc81.CountFunctionItems[i]-1 do
         begin
              p1:=sc81.PointFunction[i,j];
              Chart1.Series[i].AddXY(p1.x,p1.y,'',clRed);
         end
      end;
   end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
   if CheckBox1.Checked then sc81.PrecisionDiv:=true
   else sc81.PrecisionDiv:=false;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
   if CheckBox2.Checked then sc81.TerminalDiv:=true
   else sc81.TerminalDiv:=false;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
var
  t: real;
begin
    if Edit1.Modified then
    begin
      try
         t:=StrToFloat(Edit1.Text);
         pfr81_1.MinValue:=t;
         pfr81_2.MinValue:=t;
         pfr81_3.MinValue:=t;
         pfr81_4.MinValue:=t;
         sc81.UpdateGrafics;
      except
      end;
    end;

end;

procedure TForm1.Edit2Exit(Sender: TObject);
var
  t: real;
begin
    if Edit2.Modified then
    begin
      try
         t:=StrToFloat(Edit2.Text);
         pfr81_1.MaxValue:=t;
         pfr81_2.MaxValue:=t;
         pfr81_3.MaxValue:=t;
         pfr81_4.MaxValue:=t;
         sc81.UpdateGrafics;
      except
      end;
    end;

end;

procedure TForm1.Edit3Exit(Sender: TObject);
var
  t: real;
begin
    if Edit3.Modified then
    begin
      try
         t:=StrToFloat(Edit3.Text);
         pfr81_1.Delta:=t;
         pfr81_2.Delta:=t;
         pfr81_3.Delta:=t;
         pfr81_4.Delta:=t;
         sc81.UpdateGrafics;
      except
      end;
    end;

end;

procedure TForm1.Edit6Exit(Sender: TObject);
var
  t: integer;
begin
    if Edit6.Modified then
    begin
      try
         t:=StrToInt(Edit6.Text);
         sc81.AxisXDiv:=t;
         sc81.UpdateGrafics;
      except
      end;
    end;

end;

procedure TForm1.Edit7Exit(Sender: TObject);
var
  t: integer;
begin
   if Edit7.Modified then
   begin
     try
         t:=StrToInt(Edit7.Text);
         sc81.AxisYDiv:=t;
         sc81.UpdateGrafics;
     except
     end;
   end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
   pnt: TPoint;
begin
   pnt.X:=20;
   pnt.Y:=20;
   pfr81_1:=TProduceFunction81.Create(-2,5,-5,0.01);
   pfr81_2:=TProduceFunction81.Create(-1,5,-5,0.01);
   pfr81_3:=TProduceFunction81.Create(1,5,-5,0.01);
   pfr81_4:=TProduceFunction81.Create(2,5,-5,0.01);
   Edit1.Text:=FloatToStr(pfr81_1.MinValue);
   Edit2.Text:=FloatToStr(pfr81_1.MaxValue);
   Edit3.Text:=FloatToStr(pfr81_1.Delta);
   sc81:=TGraficFunction2d.Create(pnt,Image1.Width-30,Image1.Height-30);
   sc81.AddFunction(pfr81_1);
   sc81.AddFunction(pfr81_2);
   sc81.AddFunction(pfr81_3);
   sc81.AddFunction(pfr81_4);
end;

end.
