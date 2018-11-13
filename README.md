# Calcul Quebec and Compute Canada setup tutorials

Guillimin is going to close down. It is time to switch to a different server.

## List of servers
* [Mammouth ou mp2](https://github.com/arthurdehgan/calQ_examples/blob/master/mammouth/instructions.md)
* [Briaree](https://github.com/arthurdehgan/calQ_examples/blob/master/briaree/instructions.md)

Refer to the following tables to choose the cluster you want to use:

### Mémoire requise

| Peu de mémoire (≤ 24 Go par nœud) | Mémoire modérée | Grande mémoire (≥ 96 Go par nœud)|
|:--				|:--					|:--|
| Briarée (nœuds à 24 Go) 	| Briarée (nœuds à 48 Go)		| Briarée (nœuds à 96 Go) |
| Colosse (nœuds à 24 Go) 	| Colosse (nœuds à 48 Go)		||
| Guillimin (nœuds à 24 Go) 	| Guillimin (nœuds à 48 ou 72 Go)	| Guillimin (partition ScaleMP, 1 To)| 
|				| Mp2					| Mp2 (nœuds à grande mémoire, 256 ou 512 Go)|

### Type de réseautique

| Peu de communications entre les cœurs	| Beaucoup de communications|
| Guillimin (queue sw) | Briarée |
| Mp2 (queue qwork) | Colosse |
||Guillimin (queues hb et lm)|
||Mp2 (queue qfbb)|


### Serveurs spécialisés
| Hadès | Helios|
|serveur contenant des cartes graphiques|


