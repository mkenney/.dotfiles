# #!env bash

# export SSH_USERNAME=mkenney

# # Place this file in your home directory and add this line to your ~/.bash_profile
# # or ~/.bashrc:
# #
# #   source $HOME/validity-auth.sh
# #
# #
# # auth() - Authenticate against AWS roles using aquaduck or aws-vault.
# #
# #   auth [eo|vfe-test|vfe-prod]
# #       Authenticate into the specified AWS account. Needed for aws-cli and
# #       terraform commands.
# #   auth ssh [eo-test|eo-prod|vfe-test|vfe-prod]
# #       Create SSH keys for gateway servers. Needed to create local SSH tunnels
# #       to AWS services.
# #   auth docker
# #       Authenticate docker against various AWS ECR repositories to access
# #       images. Also authenticates into AWS.
# #
# #
# # kx() - Authenticate into a kubernetes cluster and set the appropriate context.
# # If no arguments are passed, print the current context.
# #
# #    kx [profile] [env] [workload]
# #        profile
# #            One of "eo" or "vfe". The special value "-" will switch back to the
# #            most recently used context.
# #        env
# #            One of "test" or "prod".
# #        workload
# #            The workload number to work with (1, 2, 3, etc.).
# #   eg.
# #       `kx vfe test 1`
# #           Set the kubectl context to the vfe-test workload1 cluster.
# #       `kx eo prod 4`
# #           Set the kubectl context to the eo-prod workload4 cluster.
# #       `kx -`
# #           Set the kubectl context back to the vfe-test workload1 cluster.
# #
# #
# # kn() - Get/set the namespace for the current k8s context. If no argument is
# # passed, print the current namespace.
# #
# #   kn -
# #       Switch to the most recently used namespace in the current context.
# #   kn <namespace>
# #       Set the current namespace to <namespace>.
# #
# #
# # __k8s_ps1() - Kubernetes status line for shell prompts. Displays an icon and
# # the current kubectl context and namespace:
# #
# #   '⎈ {context}::{namespace}'

# # type less
# alias a="aquaduck"
# alias k="kubectl"

# # ⎈ UTF-8 kubernetes icon.
# if [ "" = "$__K8S_PS1_SYMBOL" ]; then
#     export __K8S_PS1_SYMBOL=$'\xE2\x8E\x88'
# fi

# # init k8s context management variables
# if [ -d "$HOME/.kube" ]; then
#     export __K8S_LAST_CONTEXT=
#     export __KUBECONFIG_DEFAULT=$KUBECONFIG
#     export KUBECONFIG=$__KUBECONFIG_DEFAULT
#     export -A __K8S_LAST_NAMESPACE=()
#     export -A __K8S_CURR_NAMESPACE=()

#     current_context="$(kx)"
#     if [ "" != "$current_context" ]; then
#         current_ns=$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"${current_context}\")].context.namespace}" 2> /dev/null)
#         if [ "" != "$current_ns" ]; then
#             current_ns="default"
#         fi

#         ctxkey=$(basename $current_context)
#         ctxkey=${ctxkey//./_}
#         if [ "" != "$current_context" ]; then
#             export -A __K8S_LAST_NAMESPACE=([$ctxkey]=default)
#             export -A __K8S_CURR_NAMESPACE=([$ctxkey]=$current_ns)
#         fi
#     fi
# fi

# # auth() - Authenticate against AWS roles using aquaduck. If no arguments are
# # passed, authenticate into aws and the docker repository, and generate SSH keys
# # for gateway servers.
# #
# # - authenticate docker:  `auth docker`
# # - authenticate SSH:     `auth ssh vfe-test` (uses aquaduck)
# # - authenticate aws-cli: `auth vfe-test`
# auth() {
#     case "$1" in
#         # Docker
#         "docker")
#             echo "authenticating docker into AWS ECR"
#             old_vault=$AWS_VAULT
#             unset AWS_VAULT && aws-vault exec eo -- aws ecr get-login-password --region us-east-1 | docker login \
#                 --username AWS \
#                 --password-stdin \
#                 596297932419.dkr.ecr.us-east-1.amazonaws.com
#             exit_code=$?; if [ "0" != "$exit_code" ]; then echo "Authenticating Docker into the 'eo' account failed"; return $exit_code; fi
#             unset AWS_VAULT && aws-vault exec vfe-prod -- aws ecr get-login-password --region us-east-1 | docker login \
#                 --username AWS \
#                 --password-stdin \
#                 616752873841.dkr.ecr.us-east-1.amazonaws.com
#             exit_code=$?; if [ "0" != "$exit_code" ]; then echo "Authenticating Docker into the 'vfe-prod' account failed"; return $exit_code; fi
#             unset AWS_VAULT && eval "export AWS_VAULT=$old_vault"
#         ;;
#         # SSH keys.
#         "ssh")
#             if [ "" == "$2" ]; then
#                 aquaduck auth ssh -e eo-test
#                 aquaduck auth ssh -e eo-prod
#                 aquaduck auth ssh -e vfe-test
#                 aquaduck auth ssh -e vfe-prod
#             else
#                 aquaduck auth ssh -e ${1}
#             fi
#         ;;
#         # Default to AWS
#         *)
#             # all this is just to authenticate the current shell without exec-ing
#             # into a new subshell which is super annoying.
#             unset AWS_VAULT
#             while read -r a; do
#                 eval "export $a"
#                 exit_code=$?; if [ "0" != "$exit_code" ]; then echo "Authenticating into the '${1}' account failed"; return $exit_code; fi
#             done <<< "$(aws-vault exec ${1} -- env | grep ^AWS_)"
#             exit_code=$?; if [ "0" != "$exit_code" ]; then echo "Authenticating into the '${1}' account failed"; return $exit_code; fi
#         ;;
#     esac
# }
# export -f auth

# # kn() - Get/set the namespace for the current k8s context. If no argument is
# # passed, print the current namespace.
# #
# # i.e. `kn infrastructure`
# # i.e. `kn -` // switches back
# kn() {
#     current_context="$(kx)"
#     if [ "" = "$current_context" ]; then
#         if [ "" != "$1" ]; then
#             >&2 echo "kubernetes context is not set"
#         fi
#         $(exit 1)
#         return
#     fi

#     if [ "" != "$current_context" ]; then
#         current_ns=$(kubectl config view -o=jsonpath="{.contexts[?(@.name==\"$(kx)\")].context.namespace}" 2> /dev/null)
#     fi

#     if [ "" = "$current_ns" ]; then
#         current_ns="default"
#     fi
#     ctxkey=$(basename $current_context)
#     ctxkey=${ctxkey//./_}

#     if [ "" == "${__K8S_LAST_NAMESPACE[$ctxkey]}" ]; then
#         __K8S_LAST_NAMESPACE[$ctxkey]=$current_ns
#     fi

#     if [ "" == "${__K8S_CURR_NAMESPACE[$ctxkey]}" ]; then
#         __K8S_CURR_NAMESPACE[$ctxkey]=$current_ns
#     fi

#     if [ "" == "$1" ]; then
#         echo $current_ns
#     elif [ "-" == "$1" ]; then
#         kubectl config set-context $(kx) --namespace="${__K8S_LAST_NAMESPACE[$ctxkey]}" > /dev/null
#         __K8S_LAST_NAMESPACE[$ctxkey]=$current_ns
#         __K8S_CURR_NAMESPACE[$ctxkey]=${__K8S_LAST_NAMESPACE[$ctxkey]}
#         __k8s_ps1
#     else
#         kubectl config set-context $(kx) --namespace="$1" > /dev/null
#         __K8S_LAST_NAMESPACE[$ctxkey]=$current_ns
#         __K8S_CURR_NAMESPACE[$ctxkey]=$1
#         __k8s_ps1
#     fi

#     eval "export -A __K8S_LAST_NAMESPACE"
#     eval "export -A __K8S_CURR_NAMESPACE"
# }
# export -f kn

# # kx() - Authenticate into a kubernetes cluster and set the appropriate context.
# # If no arguments are passed, print the current context.
# #
# # i.e. `kx vfe test 2`
# # i.e. `kx kops test 2`
# # i.e. `kx eo test 5`
# kx() {
#     cluster=
#     env=$2
#     default_namespace=
#     profile=
#     workload="workload${3}"
#     region='us-east-1'
#     if [ "" != "$4" ]; then
#         region=$4
#     fi

#     if [ "" == "$__K8S_LAST_CONTEXT" ]; then
#         eval "export __K8S_LAST_CONTEXT=$(kubectl config view -o=jsonpath='{.current-context}' 2> /dev/null)"
#     fi

#     case "$1" in
#         "")
#             echo $(kubectl config view -o=jsonpath='{.current-context}' 2> /dev/null)
#             return
#         ;;
#         "-")
#             cluster=$__K8S_LAST_CONTEXT
#             if [ "" == "$cluster" ]; then
#                 >&2 echo "kubernetes context is not set"
#                 return 1
#             fi
#             if echo "$cluster" | grep -q ".k8s."; then
#                 eval "export __K8S_LAST_CONTEXT=$(kubectl config view -o=jsonpath='{.current-context}' 2> /dev/null)"
#                 eval "export KUBECONFIG=${HOME}/.kube/${cluster}/config.kops"
#                 eval "$(aquaduck auth kube $cluster --k8s-auth-type=kops -p $profile)"
#             else
#                 aws eks --region us-east-1 update-kubeconfig --name $cluster
#             fi
#             eval "export __K8S_LAST_CONTEXT=$(kubectl config view -o=jsonpath='{.current-context}' 2> /dev/null)"
#         ;;
#         "eo")
#             if [ "tst" == "$env" ]; then
#                 env="test"
#             fi
#             profile="${1}"
#             cluster="${workload}-${region}-rp-${profile}-${env}"
#             default_namespace="eo"

#             auth $profile
#             aws eks --region us-east-1 update-kubeconfig --name $cluster

#             eval "export __K8S_LAST_CONTEXT=$last"
#         ;;
#         "kops")
#             profile='eo'
#             if [ "prod" = "$env" ]; then
#                 env=
#             fi
#             if [ "test" = "$env" ]; then
#                 env="tst."
#             fi
#             auth eo
#             cluster="${workload}.k8s.${env}returnpath.net"
#             default_namespace="eo"
#             echo "cluseter $cluster"
#             #echo aws eks --region us-east-1 update-kubeconfig --name $cluster &> /dev/null
#             eval "export __K8S_LAST_CONTEXT=$(kubectl config view -o=jsonpath='{.current-context}' 2> /dev/null)"
#             mkdir "${HOME}/.kube/${cluster}"
# #            if [ !-f "${HOME}/.kube/${cluster}/config.kops" ]; then
# #                cat
# #            fi
#             eval "export KUBECONFIG=${HOME}/.kube/${cluster}/config.kops"
#             eval "$(aquaduck auth kube $cluster --k8s-auth-type=kops -p $profile)"
#         ;;
#         *)
#             if [ "tst" == "$env" ]; then
#                 env="test"
#             fi
#             profile="${1}-${2}"
#             cluster="${workload}-us-east-1-${profile}"
#             default_namespace="vfe"

#             #env cp -f ~/.kube/config ~/.kube/config.${cluster}
#             eval "export KUBECONFIG=${HOME}/.kube/config.${cluster}"
#             eval "export __K8S_LAST_CONTEXT=$(kubectl config view -o=jsonpath='{.current-context}' 2> /dev/null)"

#             auth $profile
#             aws eks --region us-east-1 update-kubeconfig --name $cluster
#         ;;
#     esac

#     # Switch to the specified context
#     ctxkey=$(basename $(kubectl config view -o=jsonpath='{.current-context}' 2> /dev/null) 2> /dev/null)
#     if [ "" != "$default_namespace" ]; then
#         if [ "" == "${__K8S_CURR_NAMESPACE}" ] || [ "" == "${__K8S_CURR_NAMESPACE[$ctxkey]}" ]; then
#             __K8S_CURR_NAMESPACE[$ctxkey]=$default_namespace
#             eval "export -A __K8S_CURR_NAMESPACE"
#         fi
#     fi

#     # Make sure it lands in the expected namespace
#     kn ${__K8S_CURR_NAMESPACE[$ctxkey]}
#     kp on
# }
# export -f kx

# # __k8s_ps1() - Kubernetes status line for shell prompts. Displays an icon and
# # the current kubectl context and namespace.
# #
# # '⎈ {context}::{namespace}'
# __k8s_ps1() {
#     if [ "enabled" = "$K8S_STATUS_LINE" ]; then
#         kx=$(basename $(kx) 2> /dev/null)
#         if [ "" != "$kx" ]; then
#             echo "$__K8S_PS1_SYMBOL ${kx}::$(kn)"
#         fi
#     fi
# }
# export -f __k8s_ps1

# # kp() - enable, disable, or toggle __k8s_ps1() status line output
# kp() {
#     if [ "" != "$1" ]; then
#         if [ "on" = "$1" ]; then
#             eval "export K8S_STATUS_LINE=enabled"
#         else
#             eval "export K8S_STATUS_LINE="
#         fi
#     else
#         if [ "enabled" = "$K8S_STATUS_LINE" ]; then
#             eval "export K8S_STATUS_LINE="
#         else
#             eval "export K8S_STATUS_LINE=enabled"
#         fi
#     fi
# }

# if [ "" = "$(which kubectl)" ] || [ "" = "$(kx)" ]; then
#     export K8S_STATUS_LINE=
# else
#     export K8S_STATUS_LINE=enabled
# fi
