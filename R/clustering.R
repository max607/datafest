
# possible variables:
# AGS 8 or 11
# Umsatzstaffel
# Mitarbeiterstaffel
# wz_code
# taxes
# Rechtsform

library(mlr3measures)
library(mlr3benchmark)

# ENCODING


# CLUSTERING
dt_firms_clust = dt_firms[!is.na(Gewerbesteuer) & !is.na(umsatz) & !is.na(kapital) &
			  rechtsform %in% c("GMBH", "GMBH_CO_KG", "AG"),
			  c("Gewerbesteuer", "umsatz", "mitarbeiter", "kapital")]
input <- c("0-99", "100-499", "500-999", "1000-2499", "1000-9999", "10000-24999", "100000-999999",
  "2500-9999", "25000-99999")
output <- c(1, 2, 3, 4, 5,
dt_firms_clust[, kapital := log(kapital)]
dt_firms_clust[, 
task = TaskClust$new("dt_firms_clust", dt_firms_clust)
# BENCHMARKING
learners = list(
  po(lrn("clust.featureless")),
  po(lrn("clust.kmeans", centers = 4L)),
  po(lrn("clust.cmeans", centers = 3L))
)
# graph = po("encode") %>>% po("scale") %>>% po(lrn("clust.cmeans", predict_type = "prob", centers = 3))
graph = po("encode") %>>% po("scale") %>>% learners
g_lrn = GraphLearner$new(graph)
g_lrn$train(task)
preds = g_lrn$predict(task = task)
meas = msrs(c("clust.wss", "clust.silhouette"))
preds$score(meas, task = task)
summary(preds$prob)
mlr3viz::autoplot(preds, task)

measures = list(msr("clust.wss"), msr("clust.silhouette"))
bmr = benchmark(benchmark_grid(task, learners, rsmp("insample")))
bmr$aggregate(measures)[, c(4, 7, 8)]
