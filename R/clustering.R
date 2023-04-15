
# possible variables:
# AGS 8 or 11
# Umsatzstaffel
# Mitarbeiterstaffel
# wz_code
# taxes
# Rechtsform


# ENCODING


# CLUSTERING
dt_firms_clust = dt_firms[, c("land", "ort", "rechtsform", "umsatz_staffel", "mitarbeiter_staffel")]
task = TaskClust$new("dt_firms_clust", dt_firms_clust)
learner = mlr_learners$get("clust.mclust")
learner$train(task)
preds = learner$predict(task = task)
