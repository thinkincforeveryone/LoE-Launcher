unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, ComCtrls, pngimage, ExtCtrls, StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdAntiFreezeBase,
  IdAntiFreeze, DFUnRar, OleCtrls, SHDocVw, INIFiles, ShellAPI;

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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    IdAntiFreeze1: TIdAntiFreeze;
    Timer2: TTimer;
    DFUnRar1: TDFUnRar;
    Edit1: TEdit;
    WebBrowser1: TWebBrowser;
    TabSheet3: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure JumpTo(const aAdress: String);
  end;

var
  Form1: TForm1;
  ArqIni: TIniFile;
  ArqLang: TIniFIle;
  Language, L1Caption01, L2Caption01, L3Caption01, L3Caption02, L3Caption03,
  L3Caption04, L3Caption05, L3Caption06, L4Caption01, CTabSheet1, CTabSheet2,
  CTabSheet3, B1Caption01 : string;
  ServerName, Version, Website, ChangeLogURL, UpdateURL, ExeFile : string;
  PExeFile : PChar;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
WinExec(PAnsiChar(ExeFile), SW_NORMAL);
close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
// -----------------------------------
if not(FileExists('version.ini')) then
begin
memo2.Lines.Clear;
memo2.Lines.Add('v1.0');
memo2.Lines.SaveToFile('version.ini');
end;
// -----------------------------------
if not(FileExists('config.ini')) then
begin
ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
ArqIni.WriteString('Configs', 'ServerName', 'LoeBR');
ArqIni.WriteString('Configs', 'Version', 'v1.0');
ArqIni.WriteString('Configs', 'Website', 'http://loebr.cf/');
ArqIni.WriteString('Configs', 'ChangelogURL', 'http://loebr.cf/launcher/changelog.html');
ArqIni.WriteString('Configs', 'UpdateURL', 'http://loebr.cf/launcher/');
ArqIni.WriteString('Launch', 'ExeFile', 'loe.exe');
end;
// -----------------------------------
if not(FileExists('language.lang')) then
begin
ArqLang := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'language.lang');
ArqLang.WriteString('Language', 'Language', 'English');
ArqLang.WriteString('Label1', 'Caption01', 'Server:');
ArqLang.WriteString('Label2', 'Caption01', 'Current version:');
ArqLang.WriteString('Label3', 'Caption01', 'Searching for updates...');
ArqLang.WriteString('Label3', 'Caption02', 'Checking for updates...');
ArqLang.WriteString('Label3', 'Caption03', 'Update completed!');
ArqLang.WriteString('Label3', 'Caption04', 'You have the latest version!');
ArqLang.WriteString('Label3', 'Caption05', 'Downloading:');
ArqLang.WriteString('Label3', 'Caption06', 'Updating the game...');
ArqLang.WriteString('Label4', 'Caption01', 'Developed by:');
ArqLang.WriteString('PageControl1', 'TabSheet1', 'Main');
ArqLang.WriteString('PageControl1', 'TabSheet2', 'Changelog');
ArqLang.WriteString('PageControl1', 'TabSheet3', 'About');
ArqLang.WriteString('Button1', 'Caption01', 'Play');
end;
// -----------------------------------
ArqLang := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'language.lang');
Language := ArqLang.ReadString('Language', 'Language', '');
L1Caption01 := ArqLang.ReadString('Label1', 'Caption01', '');
L2Caption01 := ArqLang.ReadString('Label2', 'Caption01', '');
L3Caption01 := ArqLang.ReadString('Label3', 'Caption01', '');
L3Caption02 := ArqLang.ReadString('Label3', 'Caption02', '');
L3Caption03 := ArqLang.ReadString('Label3', 'Caption03', '');
L3Caption04 := ArqLang.ReadString('Label3', 'Caption04', '');
L3Caption05 := ArqLang.ReadString('Label3', 'Caption05', '');
L3Caption06 := ArqLang.ReadString('Label3', 'Caption06', '');
L4Caption01 := ArqLang.ReadString('Label4', 'Caption01', '');
CTabSheet1 := ArqLang.ReadString('PageControl1', 'TabSheet1', '');
CTabSheet2 := ArqLang.ReadString('PageControl1', 'TabSheet2', '');
CTabSheet3 := ArqLang.ReadString('PageControl1', 'TabSheet3', '');
B1Caption01 := ArqLang.ReadString('Button1', 'Caption01', '');
// -------------------------------
Label1.Caption := L1Caption01;
Label2.Caption := L2Caption01;
Label3.Caption := L3Caption01;
Label4.Caption := L4Caption01;
TabSheet1.Caption := CTabSheet1;
TabSheet2.Caption := CTabSheet2;
TabSheet3.Caption := CTabSheet3;
Button1.Caption := B1Caption01;
// -------------------------------
Button1.Enabled := False;
// -------------------------------
ArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
ServerName := ArqIni.ReadString('Configs', 'ServerName', '');
Version := ArqIni.ReadString('Configs', 'Version', '');
Website := ArqIni.ReadString('Configs', 'Website', '');
ChangeLogURL := ArqIni.ReadString('Configs', 'ChangelogURL', '');
UpdateURL := ArqIni.ReadString('Configs', 'UpdateURL', '');
ExeFile := ArqIni.ReadString('Launch', 'ExeFile', '');
// --------------------------------
Form1.Caption := Form1.Caption + ' [' + ServerName + ']';
Label1.Caption := Label1.Caption + ' ' + ServerName;
Label2.Caption := Label2.Caption + ' ' + Version;
WebBrowser1.Navigate(ChangeLogURL);
// --------------------------------
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
if (fileexists('update.ini')) then
Label3.Caption := L3Caption02;
end;

procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
ProgressBar1.Position := ProgressBar1.Max;
Label3.Caption := L3Caption03;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
archive : string;
MyFile: TFileStream;
begin
Timer1.Enabled := False;
archive := 'currentversion.ini';
MyFile := TFileStream.Create(archive, fmCreate);
try
IdHTTP1.Get(UpdateURL + archive, MyFile);
finally
MyFile.Free;
memo2.Lines.LoadFromFile('currentversion.ini');
memo3.Lines.LoadFromFile('version.ini');
if memo2.Lines[0] = memo3.Lines[0] then
begin
button1.Enabled := true;
Label3.Caption := L3Caption04;
if (fileexists('currentversion.ini')) then
deletefile('currentversion.ini');
end else begin
archive := 'update.ini';
MyFile := TFileStream.Create(archive, fmCreate);
try
IdHTTP1.Get(UpdateURL + archive, MyFile);
finally
MyFile.Free;
memo1.Lines.LoadFromFile('update.ini');
end;
Label3.Caption := L3Caption05 + ' ' + memo1.Lines[0];
archive := memo1.Lines[0];
MyFile := TFileStream.Create(archive, fmCreate);
try
IdHTTP1.Get(UpdateURL + archive, MyFile);
finally
MyFile.Free;
Timer2.enabled := True;
end;
if (fileexists('currentversion.ini')) then
deletefile('currentversion.ini');
if (fileexists('update.ini')) then
deletefile('update.ini');
end;
end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
with Edit1 do
if Text <> '' then DFUnRAR1.Directory := Text;
DFUnRAR1.FileName := Memo1.Lines[0];
if not FileExists(DFUnRAR1.FileName) then begin
Exit;
end else begin
label3.Caption :=  L3Caption06;
DFUnRAR1.Extract;
Label3.Caption := L3Caption03;
memo2.Lines.SaveToFile('version.ini');
ArqIni.WriteString('Configs', 'Version', memo2.Lines[0]);
Label2.Caption := L2Caption01 + ' ' +  memo2.Lines[0];
Button1.Enabled := true;
end;
if FileExists(Memo1.Lines[0]) then
deletefile(Memo1.Lines[0]);
Timer2.Enabled := False;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
 JumpTo(Website);
end;

procedure TForm1.JumpTo(const aAdress: String); 
var 
       buffer: String; 
begin 
       buffer := aAdress;
       ShellExecute(Application.Handle, nil, PChar(buffer), nil, nil, SW_SHOWNORMAL); 
end;

procedure TForm1.Label7Click(Sender: TObject);
begin
 JumpTo('http://github.com/xfirespeed/LoE-Launcher');
end;

procedure TForm1.Label5Click(Sender: TObject);
begin
  JumpTo('https://github.com/xfirespeed');
end;

end.
