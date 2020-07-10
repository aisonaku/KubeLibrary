*** Settings ***
Resource          ./pod_kw.robot

*** Variables ***
${KLIB_POD_PATTERN}         %{KLIB_POD_PATTERN}
${KLIB_POD_NAMESPACE}         %{KLIB_POD_NAMESPACE}
${KLIB_POD_REPLICAS}         %{KLIB_POD_REPLICAS=1}
${KLIB_POD_TIMEOUT}         %{KLIB_POD_TIMEOUT=2min}
${KLIB_POD_RETRY_INTERVAL}  %{KLIB_POD_RETRY_INTERVAL=5sec}
${KLIB_POD_LABELS}          %{KLIB_POD_LABELS='Labels missing!'}
${KLIB_POD_ANNOTATIONS}     %{KLIB_POD_ANNOTATIONS='Annotations missing!'}
${KLIB_RESOURCE_REQUESTS_CPU}     %{KLIB_RESOURCE_REQUESTS_CPU='Resource requests missing!'}
${KLIB_RESOURCE_REQUESTS_MEMORY}     %{KLIB_RESOURCE_REQUESTS_MEMORY='Resource requests missing!'}
${KLIB_RESOURCE_LIMITS_CPU}     %{KLIB_RESOURCE_LIMITS_CPU='Resource requests missing!'}
${KLIB_RESOURCE_LIMITs_MEMORY}     %{KLIB_RESOURCE_LIMITS_MEMORY='Resource requests missing!'}
${KLIB_ENV_VARS}                   %{KLIB_ENV_VARS='Env vars missing!'}

*** Test Cases ***

Pod images has correct version
    Given waited for pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}" to be running
    When getting pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}"
    Then all pods containers are using "eu.gcr.io/kyma-project/incubator/develop/octopus:dc5dc284" image

Pod has enough replicas
    Given waited for pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}" to be running
    When getting pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}"
    Then pods have "${KLIB_POD_REPLICAS}" replicas

Pod has not been restarted
    Given waited for pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}" to be running
    When getting pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}"
    Then pods containers were not restarted

Pod have correct labels
    Given waited for pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}" to be running
    When getting pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}"
    Then pods have labels "${KLIB_POD_LABELS}"

Pod has correct annotations
    Given waited for pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}" to be running
    When getting pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}"
    Then pods have annotations "${KLIB_POD_ANNOTATIONS}"

Pod has correct limits/requests
    Given waited for pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}" to be running
    When getting pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}"
    Then pods containers have resource requests cpu "${KLIB_RESOURCE_REQUESTS_CPU}"
    Then pods containers have resource requests memory "${KLIB_RESOURCE_REQUESTS_MEMORY}"
    Then pods containers have resource limits cpu "${KLIB_RESOURCE_LIMITS_CPU}"
    Then pods containers have resource limits memory "${KLIB_RESOURCE_LIMITS_MEMORY}"

Pod has correct env variables
    Given waited for pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}" to be running
    When getting pods matching "${KLIB_POD_PATTERN}" in namespace "${KLIB_POD_NAMESPACE}"
    Then pods containers have env variables "${KLIB_ENV_VARS}"
