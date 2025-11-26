@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Proiezione della CDS ZCDS_ZBIGLIETTI'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPROJ_CDS_BIGLIETTI
  provider contract transactional_query
  as projection on ZCDS_ZBIGLIETTI as Biglietto
{
  key IdBiglietto,
      CreatoDa,
      CreatoA,
      ModificatoDa,
      ModificatoA,
      Modificato
}
