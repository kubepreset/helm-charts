{{/*
Expand the name of the chart.
*/}}
{{- define "kubepreset.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubepreset.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubepreset.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubepreset.labels" -}}
helm.sh/chart: {{ include "kubepreset.chart" . }}
{{ include "kubepreset.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubepreset.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubepreset.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubepreset.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kubepreset.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role for aggregation rule to use
*/}}
{{- define "kubepreset.clusterRoleName" -}}
{{- if .Values.rbac.create }}
{{- default (include "kubepreset.fullname" .) .Values.rbac.clusterRole.name }}
{{- else }}
{{- default "default" .Values.rbac.clusterRole.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role binding to use
*/}}
{{- define "kubepreset.clusterRoleBindingName" -}}
{{- if .Values.rbac.create }}
{{- default (include "kubepreset.fullname" .) .Values.rbac.clusterRoleBinding.name }}
{{- else }}
{{- default "default" .Values.rbac.clusterRoleBinding.name }}
{{- end }}
{{- end }}
