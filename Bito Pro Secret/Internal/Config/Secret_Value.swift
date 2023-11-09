import SwiftUI

extension Secret {
    static let `default` = Secret(
        bito: Bito(
            monitor: Bito.Monitor(
                k8s: Bito.Monitor.K8S(
                    staging: Bito.Monitor.Dashboard(
                        url: "https://k8s-dashboard.bitopro.com/#/workloads?namespace=production",
                        username: "admin",
                        password: "wk0MGXXOXUuwFUJbq7OaD68Z2i9cQeg6",
                        token: "eyJhbGciOiJSUzI1NiIsImtpZCI6Ink1a1VFNUxzSnRGRFdvdUNpcFMwNTU5MThaYTRXckdHN0dobU9JSTMtQmcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJ2aWV3LXVzZXItdG9rZW4tY2N2eGMiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoidmlldy11c2VyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiNjk0OWU0OGEtZTg0Ni00MjYxLWI4NTktYWRjNTA3YmIyOTU4Iiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmVybmV0ZXMtZGFzaGJvYXJkOnZpZXctdXNlciJ9.Jn3A93cDpn4jAU9iUujZ8Oxhp8Caxvw9RjepOTMQlUsKcKCDcXhh2oOUb3QMkWsnMapR6RwQghCqtjLp0iTEvExOUqZdmUWsS-j0rA-aasC9LPu52FzMoUIYzkfzZsM33GWDpNdnV4BCkulbjldak2CbqRgAyy6iTQazo0acoEzLJgPAuD3OG89PuqNK1lW7IOxIAuOlIR-VWcjlCJctAv7aa3GJ8lSe1ejWFpEBseBo7jOJoGHtFS1VRxkydofI9Gy4zG85RqjukwbjgQSNT1ozJJEKteLZroCdKVWMhfaVpDPsXihhgxh4DJaJ-wMbEymUHJSJQmIDTuefS2TpfQ"
                    ),
                    production: Bito.Monitor.Dashboard(
                        url: "https://stag-k8s-dashboard.bitopro.com/#/workloads?namespace=staging",
                        username: "admin",
                        password: "sdgsvxjHcyT3dw4meVAHMZOCXFEXVcn4",
                        token: "eyJhbGciOiJSUzI1NiIsImtpZCI6InJPVlA4QmlpT3NTcHpObFdEWFUwR2tHb0tLVUxmS19HRXdLa3hKeVBuSGsifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLWc0ZGc2Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIyMDYwOTJjNS1lYzQwLTRmN2UtOWFjMC1iMTI4M2M4NGJmNDUiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.M4ThL4LxZt7kgVgPEHS55LVrb_JX949rmuWOWshXfuWhmccWbAJEsHbGXtDiTdRYBXSRR7J78y3Co-L2nX3PqBmLfYuYZlEbrtpn_EfZqRJVwfZIP2GkV1P1tauHMyyTdv9qCKu6JxALh0yqv_rljhFpPPIoPNgN8p0pdfpV74l8hXPoNgSDZC7Q1m_vula4UO30v90xTDmUnP53X-_fs4hwJmb1dtJSCSifVLcFhtivoOGpBc02uaCb0MziSoX6sZ-i5kK6gTgWjMNDkz-R7SMvJkfxWfwi97j4eEqc3EUKZMm7k-X8dUKeuBfYNposZ4lHA30jHdkr2VbAeff7tg"
                    )
                ),
                other: Bito.Monitor.Other(
                    metabase: "https://metabase.link24hr.com",
                    grafana: "https://grafana.link24hr.com",
                    openSearch: "https://opensearch.bitopro.com/_dashboards/app/home#/",
                    oneSignal: "https://app.onesignal.com/apps/99247777-6e6a-4891-b89d-4636f7ccb795",
                    kafdrop: Bito.Monitor.Site(
                        staging: "https://staging-kafdrop.bitopro.com",
                        demo: "https://demo-kafdrop.bitopro.com",
                        hotfix: "https://hotfix-kafdrop.bitopro.com",
                        production: "https://kafdrop.bitopro.com"
                    ),
                    admin: Bito.Monitor.Site(
                        staging: "https://staging-admin.bitopro.com/",
                        demo: "https://demo-admin.bitopro.com/",
                        hotfix: "https://hotfix-admin.bitopro.com/",
                        production: "https://admin.bitopro.com"
                    )
                )
            ),
            deployment: Bito.Deployment(
                deployment: Bito.Deployment.Linker(
                    description: [
                        "Deployment 開發規則",
                        "RC/Prod 改 staging branch 並發 MR 給 SRE",
                        "＊ Staging/Demo/Hotfix 環境吃 staging branch",
                        "＊ RC/Prod 環境吃 master branch"
                    ]
                ),
                develop: Bito.Deployment.Linker(
                    description: [
                        "部署 Dependency Package",
                        "所有環境都是吃 development branch"
                    ],
                    natu: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/stg/job/PublishLibrariesNatu/",
                    protopuf: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/stg/job/PublishProtocolBufferIgglybuf/"
                ),
                allProject: Bito.Deployment.Linker(
                    description: [
                        "部署其他 Server",
                        "release 包版:",
                        "feature branch merge 進 demo branch ( 記得發MR )",
                        "jenkins Demo 部一版後，在 jenkins RC 包版"
                    ],
                    staging: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/stg/job/PublishForAllProject/",
                    demo: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/demo/job/CodeFreezeGeneralPipelineNew/",
                    rc: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/rc/job/ReleaseGeneralPipelineNew/"
                ),
                apiGateway: Bito.Deployment.Linker(
                    description: [
                        "部署 muffet 啦啦啦",
                        "release 包版:",
                        "feature branch merge 進 demo branch ( 記得發MR )",
                        "jenkins Demo 部一版後，在 jenkins RC 包版"
                    ],
                    staging: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/stg/job/PublishApiGatewayPipeline/",
                    demo: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/demo/job/CodeFreezeApiGatewayPipeline/",
                    rc: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/rc/job/ReleaseApiGatewayPipeline/"
                ),
                configMap: Bito.Deployment.Linker(
                    description: [
                        "Configmap 開發規則",
                        "RC/Prod 改 staging branch 並發 MR 給 SRE",
                        "＊ Staging/Demo/Hotfix 環境吃 staging branch",
                        "＊ RC/Prod 環境吃 master branch"
                    ],
                    staging: "https://jenkins.link24hr.com/job/bito-pro/job/devops/job/stg/job/StgCdConfigMapJobPipeline/",
                    demo: "https://jenkins.link24hr.com/job/bito-pro/job/devops/job/demo/job/DemoCdConfigMapJobPipeline/",
                    hotfix: "https://jenkins.link24hr.com/job/bito-pro/job/devops/job/hotfix/job/HotfixCdConfigMapJobPipeline/"
                ),
                pairDeploy: Bito.Deployment.Linker(
                    description: [
                        "部署交易對",
                        "Configmap 要記得部署"
                    ],
                    staging: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/stg/job/StgCdPairDeployPipeline/",
                    demo: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/demo/job/DemoCdPairDeployPipeline/",
                    hotfix: "https://jenkins.link24hr.com/job/bito-pro/job/back-end/job/hotfix/job/HotfixCdPairDeployPipeline/"
                ),
                orderCheck: Bito.Deployment.Linker(
                    description: [
                        "掉單檢查JOB"
                    ],
                    staging: "https://jenkins.link24hr.com/job/bito-pro_eks/job/back-end/job/stg/job/StgJobHattereneOrderCheck/",
                    demo: "https://jenkins.link24hr.com/job/bito-pro_eks/job/back-end/job/demo/job/StgJobHattereneOrderCheck/",
                    hotfix: "https://jenkins.link24hr.com/job/bito-pro_eks/job/back-end/job/hotfix/job/StgJobHattereneOrderCheck/"
                ),
                orderCancel: Bito.Deployment.Linker(
                    description: [
                        "掉單取消JOB"
                    ],
                    staging: "https://jenkins.link24hr.com/job/bito-pro_eks/job/back-end/job/stg/job/StgJobHattereneOrderCancel/",
                    demo: "https://jenkins.link24hr.com/job/bito-pro_eks/job/back-end/job/demo/job/StgJobHattereneOrderCancel/",
                    hotfix: "https://jenkins.link24hr.com/job/bito-pro_eks/job/back-end/job/hotfix/job/StgJobHattereneOrderCancel/"
                )
            ),
            database: Bito.Database(
                mysql: Bito.Database.MySQL(
                    staging: Bito.Database.Container(
                        host: "bitopro-staging-mysql-rds-cluster.cluster-cmxwzxbzjtio.ap-northeast-1.rds.amazonaws.com:3306",
                        username: "bitopro_admin",
                        password: "PSP80296639-",
                        database: "raichu_staging"
                    ),
                    demo: Bito.Database.Container(
                        host: "bitopro-staging-mysql-rds-cluster.cluster-cmxwzxbzjtio.ap-northeast-1.rds.amazonaws.com:3306",
                        username: "bitopro_admin",
                        password: "PSP80296639-",
                        database: "raichu_demo"
                    ),
                    hotfix: Bito.Database.Container(
                        host: "bitopro-staging-mysql-rds-cluster.cluster-cmxwzxbzjtio.ap-northeast-1.rds.amazonaws.com:3306",
                        username: "bitopro_admin",
                        password: "PSP80296639-",
                        database: "raichu_hotfix"
                    )),
                mongo: Bito.Database.Mongo(
                    staging: Bito.Database.Container(
                        host: "bitopro-staging-docdb.cluster-cmxwzxbzjtio.ap-northeast-1.docdb.amazonaws.com:27017",
                        username: "bitopromaster",
                        password: "PSP80296639",
                        database: "raichu_staging"
                    )
                ),
                redis: Bito.Database.Redis(
                    staging: "staging-bitopro-redis.ruv0v5.ng.0001.apne1.cache.amazonaws.com:6379",
                    demo: "demo-bitopro-redis.ruv0v5.ng.0001.apne1.cache.amazonaws.com:6379",
                    hotfix: "hotfix-bitopro-redis.ruv0v5.ng.0001.apne1.cache.amazonaws.com:6379"
                )
            ),
            other: Bito.Other(
                backendBigSecret: "https://app.clickup.com/3780765/v/dc/3kc4x-15365/3kc4x-183960",
                backendBigTresure: "https://app.clickup.com/3780765/v/dc/3kc4x-88420/3kc4x-378560",
                hr: "https://cloud.nueip.com/login/80296639",
                seat: "https://docs.google.com/spreadsheets/d/1pKDaG1yF_gjb-VE0n_4ISnLAFOTOs_weiYRf_JYHCpQ/edit#gid=1209573299",
                bitoLand: "https://sites.google.com/psp-power.com.tw/home?pli=1",
                shareMeeting: "https://meet.google.com/koa-ymjw-xve?authuser=0"
            )
        ),
        custom: nil
    )
}
