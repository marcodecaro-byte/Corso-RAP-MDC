@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCOMPONENTI_MDC'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_COMPONENTI_MDC
//  provider contract transactional_query
  as projection on ZR_COMPONENTI_MDC
  association [1..1] to ZR_COMPONENTI_MDC as _BaseEntity 
  on $projection.IdBiglietto = _BaseEntity.IdBiglietto and 
  $projection.Progressivo = _BaseEntity.Progressivo
{
  key IdBiglietto,
  key Progressivo,
  Tipoutente,
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
  _BaseEntity,
 _Biglietto : redirected to parent ZC_BIGLIETTO_NN_2
}
    
