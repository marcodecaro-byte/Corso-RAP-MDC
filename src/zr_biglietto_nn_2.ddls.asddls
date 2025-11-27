@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZBIGLIETTO_NN_2'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_BIGLIETTO_NN_2
  as select from zbiglietto_nn_2 as Biglietto
{
  key id_biglietto as IdBiglietto,
  stato as stato,
  @Semantics.user.createdBy: true
  creato_da as CreatoDa,
  @Semantics.systemDateTime.createdAt: true
  creato_a as CreatoA,
  @Semantics.user.lastChangedBy: true
  modificato_da as ModificatoDa,
  @Semantics.systemDateTime.lastChangedAt: true
  modificato_a as ModificatoA,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged
}
