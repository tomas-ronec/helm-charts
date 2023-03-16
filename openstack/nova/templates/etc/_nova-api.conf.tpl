{{ include (print .Template.BasePath "/etc/_nova.conf.tpl") . }}{{- /*
Included twice, as the the api apps only look at the nova.conf file, so we merge the options manually
*/}}

{{- include "nova.helpers.ini_sections.api_database" . }}

{{- include "ini_sections.database" . }}

{{ include "util.helpers.valuesToIni" .Values.api_metadata.config_file }}
