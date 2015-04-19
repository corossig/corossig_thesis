/* Créer un objet graphe */
Schema schema;

/* Créer les noeud et les arêtes du graphe, puis grossir le grain du graphe et création des tâches utilisateurs */
...


/* Distribution équitable des tâches sur les bancs NUMA */
schema.distribute_on_numa_nodes();

/* Simulation d'une exécution pour déclarer les données utilisées */
schema.run_function([&](Task *t)
                    {
/* Enregistre une information d'utilisation d'une donnée par une tâche */
/* La banc NUMA est déduit à partir du thread appelant */
                        schema.register_numa_data(&my_array[t->id],
                                                  t->data_size);
                    });

/* Calcul les données devant être déplacées et les déplacent sur le meilleur banc NUMA possible */
schema.move_numa_data();

/* Exécution efficace */
schema.run();
