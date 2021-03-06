object DtmControleUsuario: TDtmControleUsuario
  OldCreateOrder = False
  Height = 451
  Width = 712
  object fdQryPerfil: TFDQuery
    OnNewRecord = fdQryPerfilNewRecord
    Connection = DtmBase.fdConexao
    Transaction = DtmBase.trnConexao
    UpdateTransaction = DtmBase.trnConexao
    UpdateObject = fdUpdPerfil
    SQL.Strings = (
      'Select'
      '    p.id_perfil'
      '  , p.cd_perfil'
      '  , p.ds_perfil'
      '  , p.sn_sistema'
      '  , p.sn_ativo'
      'from USR_PERFIL p'
      'where (p.id_perfil = :id_perfil)'
      '   or (p.cd_perfil = :cd_perfil)'
      '   or (upper(p.ds_perfil) like upper(:ds_perfil))'
      'order by'
      '   p.ds_perfil')
    Left = 72
    Top = 40
    ParamData = <
      item
        Name = 'ID_PERFIL'
        DataType = ftString
        ParamType = ptInput
        Size = 38
        Value = Null
      end
      item
        Name = 'CD_PERFIL'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'DS_PERFIL'
        DataType = ftString
        ParamType = ptInput
        Size = 50
        Value = Null
      end>
  end
  object fdUpdPerfil: TFDUpdateSQL
    Connection = DtmBase.fdConexao
    InsertSQL.Strings = (
      'INSERT INTO USR_PERFIL'
      '(ID_PERFIL, CD_PERFIL, DS_PERFIL, SN_SISTEMA, '
      '  SN_ATIVO)'
      
        'VALUES (:NEW_ID_PERFIL, :NEW_CD_PERFIL, :NEW_DS_PERFIL, :NEW_SN_' +
        'SISTEMA, '
      '  :NEW_SN_ATIVO)'
      'RETURNING ID_PERFIL, CD_PERFIL')
    ModifySQL.Strings = (
      'UPDATE USR_PERFIL'
      
        'SET ID_PERFIL = :NEW_ID_PERFIL, CD_PERFIL = :NEW_CD_PERFIL, DS_P' +
        'ERFIL = :NEW_DS_PERFIL, '
      '  SN_SISTEMA = :NEW_SN_SISTEMA, SN_ATIVO = :NEW_SN_ATIVO'
      'WHERE ID_PERFIL = :OLD_ID_PERFIL'
      'RETURNING ID_PERFIL, CD_PERFIL')
    DeleteSQL.Strings = (
      'DELETE FROM USR_PERFIL'
      'WHERE ID_PERFIL = :OLD_ID_PERFIL')
    FetchRowSQL.Strings = (
      'SELECT ID_PERFIL, CD_PERFIL, DS_PERFIL, SN_SISTEMA, SN_ATIVO'
      'FROM USR_PERFIL'
      'WHERE ID_PERFIL = :ID_PERFIL')
    Left = 72
    Top = 88
  end
  object fdQryUsuario: TFDQuery
    BeforePost = fdQryUsuarioBeforePost
    OnNewRecord = fdQryUsuarioNewRecord
    Connection = DtmBase.fdConexao
    Transaction = DtmBase.trnConexao
    UpdateTransaction = DtmBase.trnConexao
    UpdateObject = fdUpdUsuario
    SQL.Strings = (
      'Select'
      '    u.id_usuario'
      '  , u.ds_login'
      '  , u.ds_primeironome'
      '  , u.ds_sobrenome'
      '  , u.ds_senha'
      '  , u.hs_usuario'
      '  , u.id_perfil'
      '  , u.sn_alterar_senha'
      '  , u.sn_ativo'
      '  , u.sn_sistema'
      '  , u.dt_ativo'
      '  , u.dt_cadastro'
      '  , u.us_cadastro'
      '  , u.dh_acesso'
      '  , (u.ds_primeironome || '#39' '#39' || u.ds_sobrenome) as ds_nome'
      '  , p.ds_perfil'
      'from USR_USUARIO u'
      '  left join USR_PERFIL p on (p.id_perfil = u.id_perfil)'
      'where (u.id_usuario = :id_usuario)'
      '   or (u.ds_login like :ds_login)'
      
        '   or (upper(u.ds_primeironome || '#39' '#39' || u.ds_sobrenome) like up' +
        'per(:ds_nome))'
      'order by'
      '     u.ds_primeironome'
      '   , u.ds_sobrenome')
    Left = 72
    Top = 136
    ParamData = <
      item
        Name = 'ID_USUARIO'
        DataType = ftString
        ParamType = ptInput
        Size = 38
        Value = Null
      end
      item
        Name = 'DS_LOGIN'
        DataType = ftString
        ParamType = ptInput
        Size = 50
      end
      item
        Name = 'DS_NOME'
        DataType = ftString
        ParamType = ptInput
        Size = 101
        Value = Null
      end>
  end
  object fdUpdUsuario: TFDUpdateSQL
    Connection = DtmBase.fdConexao
    InsertSQL.Strings = (
      'INSERT INTO USR_USUARIO'
      '(ID_USUARIO, DS_LOGIN, DS_PRIMEIRONOME, DS_SOBRENOME, '
      '  DS_SENHA, HS_USUARIO, ID_PERFIL, SN_ALTERAR_SENHA, '
      '  SN_ATIVO, SN_SISTEMA, DT_ATIVO, DT_CADASTRO, '
      '  US_CADASTRO, DH_ACESSO)'
      
        'VALUES (:NEW_ID_USUARIO, :NEW_DS_LOGIN, :NEW_DS_PRIMEIRONOME, :N' +
        'EW_DS_SOBRENOME, '
      
        '  :NEW_DS_SENHA, :NEW_HS_USUARIO, :NEW_ID_PERFIL, :NEW_SN_ALTERA' +
        'R_SENHA, '
      
        '  :NEW_SN_ATIVO, :NEW_SN_SISTEMA, :NEW_DT_ATIVO, :NEW_DT_CADASTR' +
        'O, '
      '  :NEW_US_CADASTRO, :NEW_DH_ACESSO)'
      'RETURNING ID_USUARIO, DT_CADASTRO, US_CADASTRO, DH_ACESSO')
    ModifySQL.Strings = (
      'UPDATE USR_USUARIO'
      
        'SET ID_USUARIO = :NEW_ID_USUARIO, DS_LOGIN = :NEW_DS_LOGIN, DS_P' +
        'RIMEIRONOME = :NEW_DS_PRIMEIRONOME, '
      '  DS_SOBRENOME = :NEW_DS_SOBRENOME, DS_SENHA = :NEW_DS_SENHA, '
      '  HS_USUARIO = :NEW_HS_USUARIO, ID_PERFIL = :NEW_ID_PERFIL, '
      
        '  SN_ALTERAR_SENHA = :NEW_SN_ALTERAR_SENHA, SN_ATIVO = :NEW_SN_A' +
        'TIVO, '
      '  SN_SISTEMA = :NEW_SN_SISTEMA, DT_ATIVO = :NEW_DT_ATIVO, '
      
        '  DT_CADASTRO = :NEW_DT_CADASTRO, US_CADASTRO = :NEW_US_CADASTRO' +
        ', '
      '  DH_ACESSO = :NEW_DH_ACESSO'
      'WHERE ID_USUARIO = :OLD_ID_USUARIO'
      'RETURNING ID_USUARIO, DT_CADASTRO, US_CADASTRO, DH_ACESSO')
    DeleteSQL.Strings = (
      'DELETE FROM USR_USUARIO'
      'WHERE ID_USUARIO = :OLD_ID_USUARIO')
    FetchRowSQL.Strings = (
      'Select'
      '    u.id_usuario'
      '  , u.ds_login'
      '  , u.ds_primeironome'
      '  , u.ds_sobrenome'
      '  , u.ds_senha'
      '  , u.hs_usuario'
      '  , u.id_perfil'
      '  , u.sn_alterar_senha'
      '  , u.sn_ativo'
      '  , u.sn_sistema'
      '  , u.dt_ativo'
      '  , u.dt_cadastro'
      '  , u.us_cadastro'
      '  , u.dh_acesso'
      '  , (u.ds_primeironome || '#39' '#39' || u.ds_sobrenome) as ds_nome'
      '  , p.ds_perfil'
      'from USR_USUARIO u'
      '  left join USR_PERFIL p on (p.id_perfil = u.id_perfil)'
      'WHERE u.ID_USUARIO = :ID_USUARIO')
    Left = 72
    Top = 184
  end
  object fdQryRotinaSistema: TFDQuery
    Connection = DtmBase.fdConexao
    Transaction = DtmBase.trnConexao
    UpdateTransaction = DtmBase.trnConexao
    UpdateObject = fdUpdRotinaSistema
    SQL.Strings = (
      'Select'
      '    sr.id'
      '  , sr.id_sistema'
      '  , sr.id_rotina'
      '  , sr.sn_ativo'
      '  , s.cd_sistema'
      '  , s.nm_sistema'
      '  , r.cd_rotina'
      '  , r.nm_rotina'
      '  , r.ds_rotina'
      '  , r.ix_rotina'
      '  , r.tp_rotina'
      '  , r.id_mestre'
      '  , r.sn_restringir_campo'
      
        '  , (case when r.cd_rotina <> replace(r.cd_rotina, '#39'CadastroUI'#39',' +
        ' '#39#39') then 1 else 0 end) as sn_cadastro'
      
        '  , case when r.cd_rotina <> replace(r.cd_rotina, '#39'CadastroUI'#39', ' +
        #39#39')'
      '      then r.sn_restringir_campo'
      '      else -1'
      '    end as sn_restringir_campo_edit'
      '  , ('
      '      ('
      '          Select'
      '            count(xx.id_rotina)'
      '          from SYS_ROTINA xx'
      
        '            inner join SYS_SISTEMA_ROTINA xy on (xy.id_sistema =' +
        ' sr.id_sistema and xy.id_rotina = xx.id_rotina)'
      '          where xx.id_mestre = sr.id_rotina'
      '            and xx.tp_rotina <> 4'
      '      ) + ('
      '          Select'
      '            count(xx.id_rotina)'
      '          from SYS_ROTINA xx'
      '          where xx.id_mestre in ('
      '              Select'
      '                xx.id_rotina'
      '              from SYS_ROTINA xx'
      
        '                inner join SYS_SISTEMA_ROTINA xy on (xy.id_siste' +
        'ma = sr.id_sistema and xy.id_rotina = xx.id_rotina)'
      '              where xx.id_mestre = sr.id_rotina'
      '                and xx.tp_rotina <> 4'
      '          ) and xx.tp_rotina <> 4'
      '      )'
      '    ) as qt_total_rotinas'
      '  , ('
      '      Select'
      '        count(xx.id_rotina)'
      '      from SYS_ROTINA xx'
      
        '        inner join SYS_SISTEMA_ROTINA xy on (xy.id_sistema = sr.' +
        'id_sistema and xy.id_rotina = xx.id_rotina)'
      '      where xx.id_mestre = sr.id_rotina'
      '        and xx.tp_rotina <> 4'
      '    ) as qt_rotinas'
      '  , Case ('
      '      Select'
      '        count(xx.id_rotina)'
      '      from SYS_ROTINA xx'
      
        '        inner join SYS_SISTEMA_ROTINA xy on (xy.id_sistema = sr.' +
        'id_sistema and xy.id_rotina = xx.id_rotina)'
      '      where xx.id_mestre = sr.id_rotina'
      '        and xx.tp_rotina <> 4'
      '    )'
      '      when 0'
      '        then 190 -- Cadastro'
      '      when 1'
      '        then 210 -- Pesquisa'
      '        else 021 -- Sistema'
      '    end as idx_image'
      'from SYS_SISTEMA_ROTINA sr'
      '  inner join SYS_SISTEMA s on (s.id_sistema = sr.id_sistema)'
      '  inner join SYS_ROTINA r on (r.id_rotina = sr.id_rotina)'
      'where (r.tp_rotina <> 4)'
      '  and (upper(r.nm_rotina) like upper(:nm_rotina))'
      'order by'
      '    r.ix_rotina')
    Left = 72
    Top = 232
    ParamData = <
      item
        Name = 'NM_ROTINA'
        DataType = ftString
        ParamType = ptInput
        Size = 150
        Value = ''
      end>
  end
  object fdUpdRotinaSistema: TFDUpdateSQL
    Connection = DtmBase.fdConexao
    ModifySQL.Strings = (
      '')
    FetchRowSQL.Strings = (
      'Select'
      '    sr.id'
      '  , sr.id_sistema'
      '  , sr.id_rotina'
      '  , sr.sn_ativo'
      '  , s.cd_sistema'
      '  , s.nm_sistema'
      '  , r.cd_rotina'
      '  , r.nm_rotina'
      '  , r.ds_rotina'
      '  , r.ix_rotina'
      '  , r.tp_rotina'
      '  , r.id_mestre'
      '  , r.sn_restringir_campo'
      
        '  , (case when r.cd_rotina <> replace(r.cd_rotina, '#39'CadastroUI'#39',' +
        ' '#39#39') then 1 else 0 end) as sn_cadastro'
      
        '  , case when r.cd_rotina <> replace(r.cd_rotina, '#39'CadastroUI'#39', ' +
        #39#39')'
      '      then r.sn_restringir_campo'
      '      else -1'
      '    end as sn_restringir_campo_edit'
      '  , ('
      '      ('
      '          Select'
      '            count(xx.id_rotina)'
      '          from SYS_ROTINA xx'
      
        '            inner join SYS_SISTEMA_ROTINA xy on (xy.id_sistema =' +
        ' sr.id_sistema and xy.id_rotina = xx.id_rotina)'
      '          where xx.id_mestre = sr.id_rotina'
      '            and xx.tp_rotina <> 4'
      '      ) + ('
      '          Select'
      '            count(xx.id_rotina)'
      '          from SYS_ROTINA xx'
      '          where xx.id_mestre in ('
      '              Select'
      '                xx.id_rotina'
      '              from SYS_ROTINA xx'
      
        '                inner join SYS_SISTEMA_ROTINA xy on (xy.id_siste' +
        'ma = sr.id_sistema and xy.id_rotina = xx.id_rotina)'
      '              where xx.id_mestre = sr.id_rotina'
      '                and xx.tp_rotina <> 4'
      '          ) and xx.tp_rotina <> 4'
      '      )'
      '    ) as qt_total_rotinas'
      '  , ('
      '      Select'
      '        count(xx.id_rotina)'
      '      from SYS_ROTINA xx'
      
        '        inner join SYS_SISTEMA_ROTINA xy on (xy.id_sistema = sr.' +
        'id_sistema and xy.id_rotina = xx.id_rotina)'
      '      where xx.id_mestre = sr.id_rotina'
      '        and xx.tp_rotina <> 4'
      '    ) as qt_rotinas'
      '  , Case ('
      '      Select'
      '        count(xx.id_rotina)'
      '      from SYS_ROTINA xx'
      
        '        inner join SYS_SISTEMA_ROTINA xy on (xy.id_sistema = sr.' +
        'id_sistema and xy.id_rotina = xx.id_rotina)'
      '      where xx.id_mestre = sr.id_rotina'
      '        and xx.tp_rotina <> 4'
      '    )'
      '      when 0'
      '        then 190 -- Cadastro'
      '      when 1'
      '        then 210 -- Pesquisa'
      '        else 021 -- Sistema'
      '    end as idx_image'
      'from SYS_SISTEMA_ROTINA sr'
      '  inner join SYS_SISTEMA s on (s.id_sistema = sr.id_sistema)'
      '  inner join SYS_ROTINA r on (r.id_rotina = sr.id_rotina)'
      'WHERE sr.ID = :ID')
    Left = 72
    Top = 280
  end
  object fdQryPerfilUsuario: TFDQuery
    Connection = DtmBase.fdConexao
    Transaction = DtmBase.trnConexao
    UpdateTransaction = DtmBase.trnConexao
    SQL.Strings = (
      'Select'
      '    p.cd_perfil as codigo'
      '  , p.id_perfil as id'
      '  , p.ds_perfil as description'
      '  , null as parent'
      '  , 0 as image'
      '  , p.id_perfil'
      '  , p.cd_perfil'
      '  , p.ds_perfil'
      '  , p.sn_sistema'
      '  , p.sn_ativo'
      '  , 1 as sn_perfil'
      '  , null as ds_login'
      '  , null as ds_primeironome'
      '  , null as ds_sobrenome'
      'from USR_PERFIL p'
      'where upper(p.ds_perfil) like :descricao'
      ''
      'union'
      ''
      'Select'
      '    p.cd_perfil  as codigo'
      '  , u.id_usuario as id'
      
        '  , trim(u.ds_primeironome || '#39' '#39' || u.ds_sobrenome) as descript' +
        'ion'
      '  , u.id_perfil as parent'
      '  , 2 as image'
      '  , u.id_perfil'
      '  , p.cd_perfil'
      '  , p.ds_perfil'
      '  , u.sn_sistema'
      '  , u.sn_ativo'
      '  , 0 as sn_perfil'
      '  , u.ds_login'
      '  , u.ds_primeironome'
      '  , u.ds_sobrenome'
      'from USR_USUARIO u'
      '  left join USR_PERFIL p on (p.id_perfil = u.id_perfil)'
      
        'where upper(trim(u.ds_primeironome || '#39' '#39' || u.ds_sobrenome)) li' +
        'ke :descricao'
      ''
      'order by'
      '    1'
      '  , 3')
    Left = 368
    Top = 40
    ParamData = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
        Size = 50
        Value = Null
      end>
  end
  object fdQryPermissaoAcesso: TFDQuery
    CachedUpdates = True
    Connection = DtmBase.fdConexao
    Transaction = DtmBase.trnConexao
    UpdateTransaction = DtmBase.trnConexao
    SQL.Strings = (
      'Select'
      '    r.id_rotina as id'
      '  , r.nm_rotina as description'
      '  , r.id_mestre as parent'
      '  , Case when r.id_mestre is null'
      '      then 021 -- Sistema'
      '      else'
      '        Case r.tp_rotina'
      '          when 0 then 014 -- Menu'
      '          when 3 then 213 -- Impressao'
      '          when 4 then 190 -- Campos do cadastro'
      '          else'
      '            208 -- Formularios e processos'
      '        end'
      '    end as image'
      ''
      '  , s.id_sistema'
      '  , s.nm_sistema'
      '  , r.nm_rotina'
      '  , r.id_mestre'
      ''
      '  , r.id_rotina'
      '  , r.tp_rotina'
      '  , r.ix_rotina'
      ''
      '  , p.id_acesso'
      '  , p.id_perfil'
      '  , null as id_usuario'
      '  --, p.tp_permissao'
      '  , Case when r.id_mestre is null'
      '      then -1'
      '      else p.tp_permissao'
      '    end as tp_permissao'
      'from USR_PERFIL_PERMISSAO p'
      '  inner join SYS_SISTEMA_ROTINA sr on (sr.id = p.id_acesso)'
      '  inner join SYS_SISTEMA s on (s.id_sistema = sr.id_sistema)'
      '  inner join SYS_ROTINA r on (r.id_rotina = sr.id_rotina)'
      ''
      'where p.id_perfil = :perfil'
      ''
      'union'
      ''
      'Select'
      '    r.id_rotina as id'
      '  , r.nm_rotina as description'
      '  , r.id_mestre as parent'
      '  , Case when r.id_mestre is null'
      '      then 021 -- Sistema'
      '      else'
      '        Case r.tp_rotina'
      '          when 0 then 014 -- Menu'
      '          when 3 then 213 -- Impressao'
      '          when 4 then 190 -- Campos do cadastro'
      '          else'
      '            208 -- Formularios e processos'
      '        end'
      '    end as image'
      ''
      '  , s.id_sistema'
      '  , s.nm_sistema'
      '  , r.nm_rotina'
      '  , r.id_mestre'
      ''
      '  , r.id_rotina'
      '  , r.tp_rotina'
      '  , r.ix_rotina'
      ''
      '  , u.id_acesso'
      '  , null as id_perfil'
      '  , u.id_usuario'
      '  , Case when r.id_mestre is null'
      '      then -1'
      '      else u.tp_permissao'
      '    end as tp_permissao'
      'from USR_USUARIO_PERMISSAO u'
      '  inner join SYS_SISTEMA_ROTINA sr on (sr.id = u.id_acesso)'
      '  inner join SYS_SISTEMA s on (s.id_sistema = sr.id_sistema)'
      '  inner join SYS_ROTINA r on (r.id_rotina = sr.id_rotina)'
      ''
      'where u.id_usuario = :usuario '
      ''
      'order by'
      '     5 '
      '  , 11')
    Left = 368
    Top = 88
    ParamData = <
      item
        Name = 'PERFIL'
        DataType = ftString
        ParamType = ptInput
        Size = 38
        Value = Null
      end
      item
        Name = 'USUARIO'
        DataType = ftString
        ParamType = ptInput
        Size = 38
      end>
  end
  object fdSpReplicarPermissao: TFDStoredProc
    Connection = DtmBase.fdConexao
    StoredProcName = 'SP_REPLICAR_PERMISSAO'
    Left = 368
    Top = 136
    ParamData = <
      item
        Position = 1
        Name = 'ID_PERFIL'
        DataType = ftString
        ParamType = ptInput
        Size = 38
      end>
  end
end
