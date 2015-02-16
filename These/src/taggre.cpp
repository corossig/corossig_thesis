/* Créer un objet graphe */
Schema schema;

/* Créer les noeuds du graphe */
int *mes_taches = new int[nombres_de_lignes];
for (int i = 0; i < nombres_de_lignes; i++)
    mes_taches[i] = schema.new_task(1, i);

/* Définir les arêtes du graphe */
for (int i = 0; i < nombres_de_lignes; i++)
    for (int j = 0; j < diagonale[i]; j++)
        schema.declare_dependency(mes_taches[j], mes_taches[i]);

/* Grossissement du grain du graphe */
schema.coarse("CD(4)");

/* Créer les tâches utilisateurs */
/* Chaque tâche reçoit trois tableaux contenants les informations spécifique à la tâche */
schema.setup([](int nb_taches, int *ids, int *poids, int *affinites) -> Task*
             {
                 return new my_task_class(n, ids, affinities);
             });

/* Puis nous pouvons exécuter toutes les tâches du graphe */
schema.run();

/* Ou utiliser une fonction pour traiter chaque tâche */
/* Cette méthode permet de réutiliser le graphe dans différentes parties du code */
schame.run_function([&](Task *t)
                    {
                        compute((my_task_class*)t);
                    });
