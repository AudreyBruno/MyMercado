object DmUsuarios: TDmUsuarios
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 248
  Width = 406
  object TabUsuario: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
  end
  object FDConnection: TFDConnection
    AfterConnect = FDConnectionAfterConnect
    BeforeConnect = FDConnectionBeforeConnect
    Left = 176
    Top = 16
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 264
    Top = 16
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 184
    Top = 112
  end
  object qryUsuario: TFDQuery
    Connection = FDConnection
    Left = 40
    Top = 88
  end
end
