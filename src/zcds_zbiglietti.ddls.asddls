@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Esercizio 1'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCDS_ZBIGLIETTI as select from zbiglietto_nn
{
key id_biglietto as IdBiglietto,
@Semantics: { user.createdBy: true }
creato_da as CreatoDa,
@Semantics: { systemDateTime: {createdAt: true }}
creato_a as CreatoA,
modificato_da as ModificatoDa,
modificato_a as ModificatoA    ,
case when creato_a = modificato_a
then ' '
else 'X'
end as Modificato
}
                                          
