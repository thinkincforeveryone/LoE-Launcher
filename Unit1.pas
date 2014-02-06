unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, ComCtrls, pngimage, ExtCtrls, StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdAntiFreezeBase,
  IdAntiFreeze;

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
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure Timer1Timer(Sender: TObject);
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
Label3.Caption := 'Verificando atualizações...';
end;

procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
ProgressBar1.Position := ProgressBar1.Max;
Label3.Caption := 'Atualização concluida!';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
arquivo, caminho : string;
MyFile: TFileStream;
begin
caminho := 'http://loebr.cf/';
arquivo := 'versaoatual.txt';
MyFile := TFileStream.Create('versaoatual.txt', fmCreate);
try
IdHTTP1.Get('http://loebr.cf/versaoatual.txt', MyFile);
finally
MyFile.Free;
memo2.Lines.LoadFromFile('versaoatual.txt');
memo3.Lines.LoadFromFile('versao.txt');
if memo2.Lines[0] = memo3.Lines[0] then
begin
button1.Enabled := true;
Label3.Caption := 'Atualização concluida!';
end else begin
caminho := 'http://loebr.cf/';
arquivo := 'update.txt';
MyFile := TFileStream.Create('update.txt', fmCreate);
try
IdHTTP1.Get('http://loebr.cf/update.txt', MyFile);
finally
MyFile.Free;
memo1.Lines.LoadFromFile('update.txt');
end;
Label3.Caption := 'Baixando: ' + memo1.Lines[0];
caminho := 'http://loebr.cf/';
arquivo := memo1.Lines[0];
MyFile := TFileStream.Create(memo1.Lines[0], fmCreate);
try
IdHTTP1.Get('http://loebr.cf/' + memo1.Lines[0], MyFile);
finally
MyFile.Free;
end;
memo2.Lines.SaveToFile('versao.txt');
Label3.Caption := 'Atualização concluida!';
end;
end;
Button1.Enabled := true;
Timer1.Enabled := false;
timer1.Free;
end;

end.
