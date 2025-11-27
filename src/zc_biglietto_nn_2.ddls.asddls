@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZBIGLIETTO_NN_2'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGLIETTO_NN_2
  provider contract transactional_query
  as projection on ZR_BIGLIETTO_NN_2
  association [1..1] to ZR_BIGLIETTO_NN_2 as _BaseEntity on $projection.IdBiglietto = _BaseEntity.IdBiglietto
{
  key IdBiglietto,


  stato,
  @Semantics: {
    user.createdBy: true
  }
  
  CreatoDa,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatoA,
  @Semantics: {
    user.lastChangedBy: true
  }
  ModificatoDa,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  ModificatoA,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchanged,

 _BaseEntity
}
