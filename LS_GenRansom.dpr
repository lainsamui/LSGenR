program LS_GenRansom;

uses
  System.StartUpCopy,
  FMX.Forms,
  ULSGenRansom in 'ULSGenRansom.pas' {F_LSGenRansomware};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TF_LSGenRansomware, F_LSGenRansomware);
  Application.Run;
end.
