unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, ComCtrls, pngimage, ExtCtrls, StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdAntiFreezeBase,
  IdAntiFreeze, DFUnRar;

type
  TForm1 = class(TForm)
    Image1: TImage;
    XPManifest1: TXPManifest;
    IdHTTP1: TIdHTTP;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    GroupBox2: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    IdAntiFreeze1: TIdAntiFreeze;
    Timer2: TTimer;
    DFUnRar1: TDFUnRar;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
WinExec('loe.exe', SW_NORMAL);
close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Button1.Enabled := False;
end;

procedure TForm1.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
ProgressBar1.Position := AWorkCount;
end;

procedure TForm1.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
ProgressBar1.Position := 0;
ProgressBar1.Max := AWorkCountMax;
Label3.Caption := 'Checking for updates...';
end;

procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
ProgressBar1.Position := ProgressBar1.Max;
Label3.Caption := 'Update completed!';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
archive, server : string;
MyFile: TFileStream;
begin
server := 'http://loebr.cf/launcher/';
archive := 'currentversion.ini';
MyFile := TFileStream.Create('currentversion.ini', fmCreate);
try
IdHTTP1.Get(server + archive, MyFile);
finally
MyFile.Free;
memo2.Lines.LoadFromFile('currentversion.ini');
memo3.Lines.LoadFromFile('version.ini');
if memo2.Lines[0] = memo3.Lines[0] then
begin
button1.Enabled := true;
Label3.Caption := 'You have the latest version!';
if (fileexists('currentversion.ini')) then
deletefile('currentversion.ini');
end else begin
archive := 'update.ini';
MyFile := TFileStream.Create('update.ini', fmCreate);
try
IdHTTP1.Get(server + archive, MyFile);
finally
MyFile.Free;
memo1.Lines.LoadFromFile('update.ini');
end;
Label3.Caption := 'Downloading: ' + memo1.Lines[0];
archive := memo1.Lines[0];
MyFile := TFileStream.Create(memo1.Lines[0], fmCreate);
try
IdHTTP1.Get(server + archive, MyFile);
finally
MyFile.Free;
end;
Timer2.enabled := True;
memo2.Lines.SaveToFile('version.ini');
if (fileexists('currentversion.ini')) then
deletefile('currentversion.ini');
if (fileexists('update.ini')) then
deletefile('update.ini');
//Label3.Caption := 'Update completed!';
end;
end;
Button1.Enabled := true;
Timer1.Enabled := false;
timer1.Free;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
with Edit1 do
if Text <> '' then DFUnRAR1.Directory := Text;
DFUnRAR1.FileName := Memo1.Lines[0];
if not FileExists(DFUnRAR1.FileName) then begin
Exit;
end else begin
label3.Caption :=  'Updating the game...';
DFUnRAR1.Extract;
Label3.Caption := 'Update completed!';
end;
if FileExists(Memo1.Lines[0]) then
deletefile(Memo1.Lines[0]);
Timer2.Enabled := False;
end;

end.
