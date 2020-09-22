# Spayce - Readme

## User => verification_status

La colonne `verification status` correspond au statut sur Stripe, c'est un enum comportant quatre statuts, ceux-ci sont modifiés via une écoute des Webhooks de Stripe :

- `no_account (default)` => ici le client n'a pas créer son compte sur Stripe et reçoit donc un message lui indiquant de le faire.
- `onboarded` => Ce statut est atteint une fois le formulaire de base de Stripe complété, l'utilisateur peut alors voir apparaître dans son profil un bouton vers le dashboard de Stripe.
- `information_needed` => peu de temps après l'onboarding fini Stripe demande des documents pour permettre à l'utilisateur de créer des transactions, il est donc en statut `information_needed` tant que ces documents ne sont pas validés par Stripe.
Si dans le futur, Stripe demande de nouveaux documents, ou s'ils sont périmés, l'utilisateur repassera en statut `information_needed`.
- `verified` => Le compte est vérifié, l'utilisateur peut créer des transactions sur Stripe ses documents ayant été validés.


