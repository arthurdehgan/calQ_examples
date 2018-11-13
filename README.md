# Calcul Quebec and Compute Canada setup tutorials

Guillimin is going to close down. It is time to switch to a different server.

## List of servers
* [Mammouth ou mp2](https://github.com/arthurdehgan/calQ_examples/blob/master/mammouth/instructions.md)
* [Briaree](https://github.com/arthurdehgan/calQ_examples/blob/master/briaree/instructions.md)

Refer to the following tables to choose the cluster you want to use:

### Mémoire requise

| Small amounts (≤ 24 GB per node) | Medium amounts | Large amounts (≥ 96 GB per node) |
|:--				|:--					|:--|
| Briarée (nodes with 24 GB) 	| Briarée (nodes with 48 GB)		| Briarée (nodes with 96 GB) |
| Colosse (nodes with 24 GB) 	| Colosse (nodes with 48 GB)		|Guillimin (ScaleMP node, 1 TB)|
| Guillimin (nodes with 24 GB) 	| Guillimin (nodes with 48 or 72 GB)	| Mp2 (large memory nodes, 256 or 512 GB)| 
|				| Mp2					| |

### Type de réseautique

| Peu de communications entre les cœurs	| Beaucoup de communications|
|:--|:--|
| Guillimin (sw queue) | Briarée |
| Mp2 (qwork queue) | Colosse |
||Guillimin (hb and lm queues)|
||Mp2 (qfbb queue)|


### Serveurs spécialisés

Hadès & Helios  
Server containing GPUs


