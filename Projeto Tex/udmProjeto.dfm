object dmProjeto: TdmProjeto
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 237
  Width = 353
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    LoginPrompt = False
    Left = 104
    Top = 88
  end
  object Link: TFDPhysFBDriverLink
    Left = 232
    Top = 128
  end
  object FDConsulta: TFDQuery
    Connection = FDConnection
    Left = 240
    Top = 64
  end
end
