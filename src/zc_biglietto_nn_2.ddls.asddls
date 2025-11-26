@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZBIGLIETTO_NN_2'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGLIETTO_NN_2
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_BIGLIETTO_NN_2
  association [1..1] to ZR_BIGLIETTO_NN_2 as _BaseEntity on $projection.IDBIGLIETTO = _BaseEntity.IDBIGLIETTO
{
  key IdBiglietto,
  @Semantics: {
    User.Createdby: true
  }
  CreatoDa,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatoA,
  @Semantics: {
    User.Lastchangedby: true
  }
  ModificatoDa,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  ModificatoA,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Locallastchanged,
  _BaseEntity
}
