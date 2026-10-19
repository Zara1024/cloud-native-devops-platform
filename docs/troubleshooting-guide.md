# DevOps Overview 涓€閿儴缃插疄鎴樹笌韪╁潙鍏ㄧ邯褰曟寚鍗?
> **鏂囨。閫傜敤璺緞**锛歚iac/week-1/devops-overview`  
> **鐩爣**锛氫娇鐢?Terraform 鍦ㄥ叕鏈変簯锛堣吘璁簯 + Cloudflare锛変笂鍏ㄨ嚜鍔ㄥ寲鎷夎捣楂樺彲鐢?K3s 闆嗙兢銆佺嫭绔?PostgreSQL 鏁版嵁搴擄紝骞朵竴閿儴缃叉墦閫氫紒涓氱骇 DevOps 鍏ㄩ摼璺伐鍏锋爤锛圙itLab銆丠arbor銆丣enkins銆丼onarQube銆丄rgo CD銆丳rometheus銆丟rafana銆丆osign 绛夛級銆?
---

## 涓€銆佹灦鏋勮璁′笌鐜鍑嗗

### 1.1 鏋舵瀯璁捐鍥?鏁翠釜 IaC 鑷姩鍖栨灦鏋勪富瑕佸寘鍚袱澶ч儴鍒嗭細**浜戝熀纭€璁炬柦灞?* 涓?**Kubernetes DevOps 骞冲彴灞?*銆?
```
                              鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?                              鈹?      Cloudflare DNS 瑙ｆ瀽绠＄悊              鈹?                              鈹? (*.devops.example.com -> CVM)  鈹?                              鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?                                                    鈹?                                                    鈻?鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹?鑵捐浜戦娓湴鍩?(ap-hongkong-2)                                                          鈹?鈹?                                                                                       鈹?鈹?  鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?  鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹? 鈹?鈹?  鈹?VPC: tf-vpc (10.0.0.0/16)               鈹?  鈹?VPC: tf-pg-vpc (10.0.0.0/16)      鈹? 鈹?鈹?  鈹?Subnet: tf_subnet (10.0.1.0/24)         鈹?  鈹?Subnet: tf_subnet (10.0.1.0/24)   鈹? 鈹?鈹?  鈹?                                        鈹?  鈹?                                  鈹? 鈹?鈹?  鈹? 鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹? 鈹?  鈹? 鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹? 鈹? 鈹?鈹?  鈹? 鈹?CVM: terraform-cvm-k8s-0          鈹? 鈹?  鈹? 鈹?CVM: terraform-cvm-pg-0     鈹? 鈹? 鈹?鈹?  鈹? 鈹?瑙勬牸: S6.4XLARGE32 (16C 32G)       鈹? 鈹?  鈹? 鈹?瑙勬牸: S5.MEDIUM2 (2C 2G)    鈹? 鈹? 鈹?鈹?  鈹? 鈹?璁¤垂: 绔炰环瀹炰緥 (SPOTPAID)         鈹? 鈹?  鈹? 鈹?璁¤垂: 绔炰环瀹炰緥 (SPOTPAID)   鈹? 鈹? 鈹?鈹?  鈹? 鈹?鎿嶄綔绯荤粺: Ubuntu 22.04 LTS        鈹? 鈹?  鈹? 鈹?鎿嶄綔绯荤粺: Ubuntu 22.04 LTS  鈹? 鈹? 鈹?鈹?  鈹? 鈹?                                  鈹? 鈹?  鈹? 鈹?                            鈹? 鈹? 鈹?鈹?  鈹? 鈹?鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? 鈹?  鈹? 鈹?鈹屸攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? 鈹? 鈹?鈹?  鈹? 鈹?鈹?K3s Kubernetes (楂樺彲鐢ㄦā寮?   鈹?鈹? 鈹?  鈹? 鈹?鈹?Docker Compose          鈹?鈹? 鈹? 鈹?鈹?  鈹? 鈹?鈹? - GitLab CE (甯?Shell 2222) 鈹?鈹? 鈹?  鈹? 鈹?鈹? 鈹斺攢 PostgreSQL 14.2     鈹?鈹? 鈹? 鈹?鈹?  鈹? 鈹?鈹? - Harbor 浼佷笟闀滃儚浠撳簱        鈹?鈹傗梽鈹€鈹尖攢鈹€鈹€鈹尖攢鈹€鈹尖攢鈹尖攢  (K3s 鍚庣瀛樺偍 & 涓氬姟)  鈹?鈹? 鈹?鈹?  鈹? 鈹?鈹? - Jenkins 鑷姩鍖栨祦姘寸嚎       鈹?鈹? 鈹?  鈹? 鈹?鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? 鈹? 鈹?鈹?  鈹? 鈹?鈹? - SonarQube 浠ｇ爜璐ㄩ噺闂ㄧ     鈹?鈹? 鈹?  鈹? 鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹? 鈹? 鈹?鈹?  鈹? 鈹?鈹? - Argo CD & Image Updater   鈹?鈹? 鈹?  鈹? Security Group: web-sg (22, 5432)鈹? 鈹?鈹?  鈹? 鈹?鈹? - Prometheus & Grafana & Loki鈹?鈹? 鈹?  鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹? 鈹?鈹?  鈹? 鈹?鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?鈹? 鈹?                                         鈹?鈹?  鈹? 鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹? 鈹?                                         鈹?鈹?  鈹? Security Group: web-sg (80,443,6443,   鈹?                                         鈹?鈹?  鈹?                         22,2222,ICMP)  鈹?                                         鈹?鈹?  鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?                                         鈹?鈹斺攢鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹?```

### 1.2 鍓嶇疆渚濊禆鍑嗗
1. **Terraform CLI**锛?   - 寤鸿鐗堟湰锛歚v1.5.0+`锛堟湰椤圭洰杩愯鐜涓?`v1.15.7` on `windows_amd64`锛夈€?   - 楠岃瘉鍛戒护锛歚terraform version`銆?2. **鑵捐浜戣处鍙峰嚟璇?*锛?   - `SecretId` 涓?`SecretKey`锛堥渶鍏峰 CVM銆乂PC銆佸畨鍏ㄧ粍绛変簯璧勬簮鐨勫垱寤轰笌绠＄悊鏉冮檺锛夈€?3. **Cloudflare 璐﹀彿涓庡煙鍚?*锛?   - 宸叉墭绠′簬 Cloudflare 鐨勪富鍩熷悕锛堝 `example.com`锛夈€?   - 鍏峰 `Zone.DNS` 璇诲啓鏉冮檺鐨?Cloudflare API Token銆?
---

## 浜屻€侀儴缃插疄鎴樻楠?
### 2.1 姝ラ 1锛氬噯澶囧彉閲忛厤缃枃浠?`terraform.tfvars`
鍦?`iac/week-1/devops-overview` 鐩綍涓嬪垱寤?`terraform.tfvars` 鏂囦欢锛岄泦涓淮鎶ゆ晱鎰熷嚟鎹拰鍩熷悕鍙傛暟锛岄伩鍏嶅湪鍛戒护琛屼腑娉勯湶鏄庢枃锛?
```hcl
# 鑵捐浜?API 璁块棶鍑嵁
secret_id  = "YOUR_TENCENTCLOUD_SECRET_ID"
secret_key = "YOUR_TENCENTCLOUD_SECRET_KEY"

# Cloudflare API Token 涓庡煙鍚?cloudflare_api_key = "YOUR_CLOUDFLARE_API_KEY"
domain             = "example.com"
prefix             = "devops"

# 鍙€夛細鍦板煙涓庡彲鐢ㄥ尯閰嶇疆锛堥粯璁?ap-hongkong / ap-hongkong-2锛?region            = "ap-hongkong"
availability_zone = "ap-hongkong-2"

# 璁¤垂绫诲瀷锛歋POTPAID锛堢珵浠峰疄渚嬶紝楂樻€т环姣旓級锛岃嫢棰濆害涓嶈冻鍙垏鎹负 POSTPAID_BY_HOUR
instance_charge_type = "SPOTPAID"
```

### 2.2 姝ラ 2锛氬垵濮嬪寲宸ヤ綔鍖?(`terraform init`)
鎵ц宸ヤ綔鍖哄垵濮嬪寲锛屼笅杞藉苟閿佸畾鎵€闇€ Provider 鎻掍欢锛?
```bash
terraform init
```
**杈撳嚭璇存槑**锛?- `tencentcloudstack/tencentcloud`: 鑵捐浜戝熀纭€璁炬柦 Provider锛坄v1.81.5`锛夈€?- `cloudflare/cloudflare`: Cloudflare DNS 瑙ｆ瀽 Provider锛坄~> 4.0`锛夈€?- `hashicorp/null`: 鐢ㄤ簬鎵ц SSH 杩滅▼ Provisioner 鑴氭湰鐨?Null Provider銆?
### 2.3 姝ラ 3锛氳娉曟牎楠屼笌鎵ц璁″垝瀹℃煡 (`terraform plan`)
杩愯鏍￠獙涓庤鍒掗妫€锛?
```bash
# 璇硶妫€鏌?terraform validate

# 鐢熸垚骞跺鏌ユ墽琛岃鍒?terraform plan
```
璁″垝涓簲鍖呭惈 **29 涓緟鍒涘缓璧勬簮**锛堟垨鍘婚櫎宸插缓瀹夊叏缁勮鍒欏悗鐨勫緟鍒涘缓椤癸級锛屽寘鎷?2 濂楃嫭绔嬬殑 VPC銆佸瓙缃戙€佽矾鐢辫〃銆佸畨鍏ㄧ粍瑙勫垯銆? 鍙?CVM 瀹炰緥銆? 鏉?Cloudflare A 璁板綍浠ュ強 2 涓?SSH Remote-Exec 鍒濆鍖栦换鍔°€?
### 2.4 姝ラ 4锛氳嚜鍔ㄥ寲閮ㄧ讲鎵ц (`terraform apply`)
涓€閿墽琛屽畬鏁撮儴缃叉祦绋嬶細

```bash
terraform apply -auto-approve
```

鏁翠釜鎵ц杩囩▼閫氬父鎸佺画 10~15 鍒嗛挓锛屾墽琛屾祦绋嬬粏鍒嗕负锛?1. **缃戠粶灞傚垱寤?*锛氬苟鍙戝垱寤?`tf-vpc`銆乣tf-pg-vpc` 鍙婂叾 Subnet銆丷oute Table銆丼ecurity Group锛?2. **璁＄畻灞傛媺璧?*锛氬苟鍙戠敵璇?`terraform-cvm-k8s-0`锛?6C 32G锛変笌 `terraform-cvm-pg-0`锛?C 2G锛夊疄渚嬪苟鑾峰彇鍏綉 IP锛?3. **DNS 瑙ｆ瀽閰嶇疆**锛氳嚜鍔ㄥ湪 Cloudflare 鍐欏叆鍚勫瓙鍩熷悕鐨?A 璁板綍瑙ｆ瀽鎸囧悜 K8s 鑺傜偣鍏綉 IP锛?4. **PostgreSQL 鑺傜偣 Provision**锛歋SH 鐧诲綍 PG 鑺傜偣锛屽畨瑁?Docker 骞堕€氳繃 Docker Compose 鍚姩 Postgres 14 瀹瑰櫒锛岄厤缃仴搴锋鏌ワ紱
5. **K3s 鑺傜偣 Provision**锛氬畨瑁?yq銆乭elm銆乸ostgresql-client 绛夊熀纭€ CLI锛岀瓑寰?PG 鏁版嵁搴撳彲杈撅紝鎷夎捣楂樺彲鐢?K3s 闆嗙兢锛屽苟渚濇閮ㄧ讲锛?   - Loki & Prometheus & Grafana 鐩戞帶鏍堬紱
   - GitLab CE 瀹炰緥锛屽苟閰嶇疆 Cloudflare 鑷姩 SSL 璇佷功锛?   - 鑷姩鐢熸垚 GitLab PAT 骞跺垱寤虹ず鑼冮」鐩?`camp-go-example` 鍜?Helm Chart 浠撳簱锛?   - Harbor 绉佹湁闀滃儚浠撳簱銆侀厤缃?Cosign 绛惧悕鏍￠獙锛?   - SonarQube 浠ｇ爜瀹℃煡鏈嶅姟锛岀敓鎴?Token 骞堕厤缃?Webhook锛?   - Jenkins 鏈嶅姟鍙婄浉鍏?Kubernetes Secret銆丣CasC 娴佹按绾块厤缃紱
   - Argo CD 鍙婂叾 Image Updater 鑷姩鍚屾鐩戝惉 Harbor銆?
---

## 涓夈€侀儴缃查亣鍒扮殑鏍稿績闂涓庢牴鍥犳帓鏌ュ叏璁板綍

鍦ㄨ窇閫氬師宸ョ▼鐨勮繃绋嬩腑锛屽叡瀹氫綅鍑?**14 椤逛弗閲嶅奖鍝嶉儴缃茬殑鑷村懡缂洪櫡涓庨樆鏂€?Bug**锛屽叿浣撴帓鏌ヨ繃绋嬩笌淇鏂规濡備笅锛?
---

### 闂涓€锛欳loudflare 鍩熷悕 Zone 鏈壘鍒?(`Error: no zone found`)

- **鐜拌薄**锛氭墽琛?`terraform plan` 鏃讹紝鎺у埗鍙版姏鍑烘姤閿欙細
  ```text
  Error: no zone found
    with data.cloudflare_zone.this,
    on cloudflare.tf line 5, in data "cloudflare_zone" "this":
     5: data "cloudflare_zone" "this" {
  ```
- **鎺掓煡杩囩▼**锛?  1. 妫€鏌?`cloudflare.tf`锛屽彂鐜版暟鎹簮閫氳繃 `name = var.domain` 鏌ヨ鐩爣鍩熷悕鐨?Zone ID銆?  2. 鏌ョ湅 `variables.tf`锛宍domain` 榛樿鍊肩‖缂栫爜涓哄師璇剧▼浣滆€呯殑 `gkdevopscamp.com`銆?  3. 浣跨敤鐢ㄦ埛鎻愪緵鐨?API Token 璋冪敤 Cloudflare REST API 鏌ヨ鍏惰处鍙蜂笅瀹為檯鎵樼鐨勫煙鍚嶏細
     ```bash
     curl.exe -s -X GET "https://api.cloudflare.com/client/v4/zones" \
       -H "Authorization: Bearer <API_TOKEN>"
     ```
     杩斿洖缁撴灉鏄剧ず璇?Token 鎵€灞炵敤鎴疯处鍙蜂负 `user@example.com`锛屽疄闄呮墭绠＄殑 Zone 鍩熷悕涓?**`example.com`**锛圸one ID: `47dc93e77f0002a933f33afe902c497a`锛夈€?- **鏍瑰洜鍒嗘瀽**锛?  Terraform 鍙橀噺涓殑榛樿涓诲煙鍚嶄笌瀹為檯浼犲叆鐨?Cloudflare Token 鏉冮檺鑼冨洿涓嶅尮閰嶏紝瀵艰嚧 Cloudflare Provider 鏌ヨ Zone 涓虹┖銆?- **瑙ｅ喅鏂规**锛?  鍦?`terraform.tfvars` 涓樉寮忔寚瀹?`domain = "example.com"`锛屽苟璁剧疆浜岀骇鍩熷悕鍓嶇紑 `prefix = "devops"`銆?
---

### 闂浜岋細鑵捐浜?VPC 缁勬挱鍔熻兘鏈巿鏉?(`The multicast feature is not authorized`)

- **鐜拌薄**锛?  鎵ц `terraform apply` 鍒涘缓 VPC 鍜屽瓙缃戣祫婧愭椂涓柇锛屾姤閿欏涓嬶細
  ```text
  Error: [TencentCloudSDKError] Code=UnauthorizedOperation, 
  Message=The multicast feature is not authorized, RequestId=1c80c3b5-ceb5-4846-bed8-6029386a83a4
    with tencentcloud_vpc.tf_vpc,
    on vpc.tf line 8, in resource "tencentcloud_vpc" "tf_vpc":
     8: resource "tencentcloud_vpc" "tf_vpc" {
  ```
- **鎺掓煡杩囩▼**锛?  1. 妫€鏌ユ墽琛岃鍒掑彂鐜帮紝`tencentcloud_vpc` 鍜?`tencentcloud_subnet` 鐨勫睘鎬т腑 `is_multicast` 琚粯璁よ绠椾负 `+ is_multicast = true`銆?  2. 鏌ラ槄鑵捐浜?VPC 瀹樻柟鏂囨。鍙煡锛岀粍鎾紙Multicast锛夊睘浜庝紒涓氱骇/鐧藉悕鍗曢珮绾х綉缁滅壒鎬э紝鏅€氱鎴疯处鍙峰湪鍒涘缓 VPC 鏃跺鏋滆姹傚惎鐢ㄧ粍鎾紝浼氳鑵捐浜?OpenAPI 鐩存帴鎷︽埅骞惰繑鍥?`UnauthorizedOperation`銆?- **鏍瑰洜鍒嗘瀽**锛?  鏃╂湡鐗堟湰 `tencentcloud` Provider 鍦ㄥ畾涔夎祫婧愭ā鏉挎椂灏?`is_multicast` 榛樿鍊艰璁炬垨榛樿寮€鍚紝瀵艰嚧鍒涘缓璇锋眰鎼哄甫浜嗘湭鎺堟潈瀛楁銆?- **瑙ｅ喅鏂规**锛?  鍦?`vpc.tf` 鍜?`pg/vpc.tf` 涓负鎵€鏈?`tencentcloud_vpc` 鍜?`tencentcloud_subnet` 鏄惧紡璁剧疆 `is_multicast = false`锛?  ```hcl
  resource "tencentcloud_vpc" "tf_vpc" {
    name         = "tf-vpc"
    cidr_block   = var.vpc_cidr
    is_multicast = false
  }
  
  resource "tencentcloud_subnet" "tf_service_subnet" {
    vpc_id            = tencentcloud_vpc.tf_vpc.id
    name              = "tf_subnet"
    cidr_block        = var.web_cidr
    availability_zone = var.availability_zone
    route_table_id    = tencentcloud_route_table.tf_routetable.id
    is_multicast      = false
    tags              = var.tags
  }
  ```

---

### 闂涓夛細绗笁鏂归暅鍍忓姞閫熸簮澶辨晥涓?GitHub 杩滅鍒嗘敮 404

- **鐜拌薄**锛?  鍦?`init.sh.tpl` 涓墽琛?`setup_argo_image_updater` 鏃讹紝浠诲姟闀挎椂闂村崱姝绘寕璧锋垨鎶ラ敊 404锛?  ```bash
  kubectl apply -n argocd -f https://ghproxy.com/https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml
  ```
- **鎺掓煡杩囩▼**锛?  1. 鍗曠嫭閽堝 `https://ghproxy.com` 鍙戣捣缃戠粶鎺㈡祴锛屽彂鐜拌绗笁鏂逛唬鐞嗘湇鍔℃棭宸插仠姝㈢淮鎶や笖缃戠粶鐩存帴榛戞礊鎸傝捣銆?  2. 鍓ョ鍔犻€熷墠缂€鐩存帴璁块棶瀹樻柟婧愶細
     ```bash
     curl -sI "https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml"
     # 杩斿洖: HTTP/1.1 404 Not Found
     ```
  3. 杩涗竴姝ユ煡闃?`argocd-image-updater` 瀹樻柟浠撳簱鐨?Git 鍒嗘敮涓?Tag锛屽彂鐜颁笂娓哥淮鎶よ€呭凡绉婚櫎浜?`stable` 鍒嗘敮锛屾寮忓畨瑁呮竻鍗曞凡鏀圭敤鎸夌増鏈彂甯冿紙渚嬪 `v0.12.2`锛夈€?- **鏍瑰洜鍒嗘瀽**锛?  鑴氭湰寮轰緷璧栧凡姝绘帀鐨勭涓夋柟鍙嶅悜浠ｇ悊锛屽悓鏃剁‖缂栫爜浜嗕笂娓稿凡搴熷純鐨?Git 鍒嗘敮鍚嶃€傛澶栵紝鐢变簬 CVM 浣嶄簬鑵捐浜戦娓湴鍩燂紝鏈氨鍏峰瀹屽叏鐩存帴璁块棶 GitHub 鐨勮兘鍔涳紝鏃犻渶浠讳綍鍥藉唴鍔犻€熶唬鐞嗐€?- **瑙ｅ喅鏂规**锛?  淇敼 `init.sh.tpl` 绗?375 琛岋紝绉婚櫎 `ghproxy.com` 骞跺浐瀹氫负鍙敤鐨勫畼鏂圭ǔ瀹氬彂琛岀増娓呭崟锛?  ```bash
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/v0.12.2/manifests/install.yaml
  ```

---

### 闂鍥涳細Ubuntu 榛樿 Shell (`dash`) 瀵艰嚧杩滅▼鑴氭湰璇硶鍏煎鎬ф晠闅?
- **鐜拌薄**锛?  `k3s.tf` 涓?remote-exec 鎵ц鍣ㄤ娇鐢?`sh /tmp/init.sh` 鍚姩瀹夎锛屽湪鑴氭湰鎵ц杩囩▼涓洜 Bash 鐗规湁璇硶鎶ヨ娉曢敊璇紓甯镐腑鏂€?- **鎺掓煡杩囩▼**锛?  鍦?Ubuntu 绯荤粺涓紝`/bin/sh` 榛樿杞摼鎺ユ寚鍚戣交閲忕骇鐨?`dash`锛圖ebian Almquist Shell锛夛紝骞堕潪瀹屾暣鐨?`bash`銆傝€?`init.sh.tpl` 澶撮儴澹版槑浜?`#!/bin/bash`锛屽苟鍦ㄥ澶勪娇鐢ㄤ簡 Bash 鐨勬潯浠惰鍙ャ€佹暟缁勫強鎵╁睍琛ㄨ揪寮忋€?- **鏍瑰洜鍒嗘瀽**锛?  Terraform remote-exec 鏄惧紡璋冪敤 `sh /tmp/init.sh` 寮哄埗浣跨敤浜?`dash` 瑙ｉ噴鍣紝蹇界暐浜嗘枃浠跺ご閮ㄧ殑 Shebang 澹版槑銆?- **瑙ｅ喅鏂规**锛?  淇敼 `k3s.tf` 涓殑 remote-exec 鍛戒护锛屾樉寮忔寚瀹?`bash /tmp/init.sh`锛?  ```hcl
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "bash /tmp/init.sh",
    ]
  }
  ```

---

### 闂浜旓細妯″潡闂村苟鍙戞墽琛岀珵鎬佷笌渚濊禆鏈樉寮忓０鏄?(`depends_on`)

- **鐜拌薄**锛?  鍦ㄥ垵濮嬮厤缃笅锛孴erraform 浼氬悓鏃跺苟鍙戞墽琛?`module.pg` 涓庢牴妯″潡鐨?`null_resource.connect_ubuntu`銆傚綋 K3s 鑺傜偣鎵ц `setup_cli` 瀹屾垚鍚庤繘鍏?`wait_pg` 闃舵鏃讹紝PG 鑺傜偣鐨勪簯鏈嶅姟鍣ㄧ敋鑷冲皻鏈畬鎴?Docker 瀹夎涓庡鍣ㄦ媺璧凤紝瀵艰嚧闀挎椂闂寸瓑寰呯敋鑷宠秴鏃躲€?- **鎺掓煡杩囩▼**锛?  妫€鏌?`k3s.tf`锛宍null_resource.connect_ubuntu` 浠呭湪妯℃澘鍙傛暟涓紩鐢ㄤ簡 `module.pg.public_ip`锛屼絾 Terraform 浠呰兘寰楃煡 IP 渚濊禆锛堜竴鏃?CVM 瀹炰緥鍒涘缓鎴愬姛 IP 灏卞凡纭畾锛夛紝鏃犳硶鎰熺煡 PG 鑺傜偣鍐呴儴閫氳繃 `null_resource.connect_pg_cvm` 鎵ц鐨?Docker 瀹夎涓庢暟鎹簱鍒濆鍖栫姸鎬併€?- **鏍瑰洜鍒嗘瀽**锛?  璺ㄦā鍧楄祫婧愬瓨鍦?*闅愬紡鐢熷懡鍛ㄦ湡渚濊禆**锛屾湭鏄惧紡澹版槑 DAG锛堟湁鍚戞棤鐜浘锛夋墽琛岄『搴忋€?- **瑙ｅ喅鏂规**锛?  鍦?`k3s.tf` 鐨?`null_resource.connect_ubuntu` 涓鍔犳樉寮忎緷璧栵細
  ```hcl
  resource "null_resource" "connect_ubuntu" {
    depends_on = [module.pg]
    ...
  }
  ```
  纭繚 Terraform 蹇呴』鍦?`module.pg` 鍏ㄩ儴璧勬簮锛堝寘鍚暟鎹簱瀹瑰櫒鍚姩瀹屾垚锛夊氨缁悗锛屾墠瑙﹀彂 K3s 涓昏妭鐐圭殑鍒濆鍖栥€?
---

### 闂鍏細GitLab Personal Access Token 鑷姩鍖栬幏鍙栫殑鑴嗗急鎬ф敼杩?
- **鐜拌薄**锛?  `init.sh.tpl` 涓€氳繃妯℃嫙 `curl` 鐖彇 GitLab 鐧诲綍椤靛苟姝ｅ垯鍖归厤 CSRF Token 鍜?Token 鐢熸垚缁撴灉锛?  ```bash
  csrf_token=$(echo $body_header | perl -ne 'print "$1\n" if /new_user.*?authenticity_token"[[:blank:]]value="(.+?)"/' | sed -n 1p)
  ```
  鍦?GitLab 鐗堟湰杩唬锛堟垨鍓嶇椤甸潰鍝嶅簲缁撴瀯寰皟锛夋椂锛屾瀬鏄撳洜姝ｅ垯鍖归厤钀界┖瀵艰嚧 `personal_access_token` 涓虹┖锛屾渶缁堜娇鏁翠釜鑴氭湰鍦ㄧ 107 琛岄€€鍑轰腑鏂€?- **瑙ｅ喅鏂规**锛?  鍦?`init.sh.tpl` 鐨?`setup_gitlab` 涓鍔犲弻閲嶄繚闄╂満鍒躲€備竴鏃﹂〉闈㈢埇鍙栦负绌猴紝绔嬪嵆鑷姩杩涘叆 Kubernetes Pod 鍐呴儴鐩存帴鍒╃敤 `gitlab-rails runner` 鍦ㄦ暟鎹簱灞傞潰绋冲畾鍒涘缓 PAT锛?  ```bash
  if [ -z "$personal_access_token" ]; then
    echo "Web scraping returned empty token, attempting to generate GitLab PAT via gitlab-rails..."
    toolbox_pod=$(kubectl get pod -n gitlab -l app=toolbox -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || kubectl get pod -n gitlab -l app=webservice -o jsonpath='{.items[0].metadata.name}')
    if [ -n "$toolbox_pod" ]; then
      personal_access_token="glpat-$(openssl rand -hex 10)"
      kubectl exec -n gitlab "$toolbox_pod" -c toolbox -- gitlab-rails runner "user = User.find_by_username('root'); token = user.personal_access_tokens.create(scopes: ['api', 'read_repository', 'write_repository', 'sudo'], name: 'devops-auto-token'); token.set_token('$personal_access_token'); token.save!" 2>/dev/null || \
      kubectl exec -n gitlab "$toolbox_pod" -- gitlab-rails runner "user = User.find_by_username('root'); token = user.personal_access_tokens.create(scopes: ['api', 'read_repository', 'write_repository', 'sudo'], name: 'devops-auto-token'); token.set_token('$personal_access_token'); token.save!" 2>/dev/null
      echo "GitLab personal access token (via rails): "$personal_access_token
    fi
  fi
  ```

---

### 闂涓冿細SonarQube 瀹瑰櫒 Ready 涓?Web 寮曟搸鍒濆鍖?503 绔炴€?
- **鐜拌薄**锛?  SonarQube 瀹夎鍚庯紝`kubectl wait --for=condition=Ready pod/sonarqube-sonarqube-0` 杩呴€熼€氳繃锛屼絾闅忓悗璋冪敤鐨?`http://sonar.${domain}/api/projects/create` 鍋跺彂鎶?`503 Service Unavailable`銆?- **鏍瑰洜鍒嗘瀽**锛?  SonarQube 灞炰簬 Java 閲嶅瀷搴旂敤锛孭od 鎺㈤拡 Ready 浠呬唬琛ㄧ鍙ｇ洃鍚紑鍚紝鍏跺唴閮ㄧ殑 Search Engine锛圗lasticsearch锛変笌 Compute Engine 闇€瑕侀澶栫殑 1~2 鍒嗛挓杩涜鎻掍欢鍔犺浇涓庢暟鎹簱杩佺Щ銆?- **瑙ｅ喅鏂规**锛?  鍦ㄨ皟鐢ㄩ」鐩垱寤?API 鍓嶏紝澧炲姞瀵?SonarQube 绯荤粺鏍稿績鐘舵€佹帰閽堢殑闃诲杞锛?  ```bash
  echo "Waiting for SonarQube status UP"
  until curl -s http://sonar.${domain}/api/system/status | grep -q '"status":"UP"'; do
      sleep 3
  done
  ```

---

### 闂鍏細棣欐腐鍦板煙 S5 涓栦唬 16C 32G 瑙勬牸搴撳瓨鑰楀敖涓庣珵浠烽厤棰濊秴闄?
- **鐜拌薄**锛?  1. 鍒濆閰嶇疆涓嬪垱寤?K3s 鑺傜偣锛坄tencentcloud_instance.ubuntu[0]`锛変娇鐢?`SPOTPAID`锛屾姏鍑烘姤閿欙細
     ```text
     Error: [TencentCloudSDKError] Code=LimitExceeded.SpotQuota, 
     Message=The quota of spot instance types is insufficient.
     ```
  2. 鍒囨崲涓?`POSTPAID_BY_HOUR`锛堟寜閲忚璐癸級鍚庨噸璇曪紝鍐嶆鎶涘嚭搴曞眰鐗╃悊鏈哄敭缃勯敊璇細
     ```text
     Error: [TencentCloudSDKError] Code=ResourceInsufficient.SpecifiedInstanceType, 
     Message=The specified type of instance is understocked.
     ```
- **鎺掓煡杩囩▼**锛?  1. 閫氳繃 `terraform console` 娣卞叆鍒嗘瀽 `data.tencentcloud_instance_types.default` 鐨勫簳灞傝繑鍥炵粨鏋滐紝鍙戠幇 `S5.4XLARGE32` 鍦ㄩ娓簩鍖虹殑鐪熷疄搴撳瓨鐘舵€佹槑纭爣璁颁负锛歚"status" = "SOLD_OUT"`銆?  2. 鍦ㄦ暟鎹簮涓紑鍚?`exclude_sold_out = true` 杩涜瀛橀噺鏈哄瀷鍔ㄦ€佹帰娴嬶紝鍙戠幇鑵捐浜戝凡灏嗙畻鍔涗富鍔涘崌绾ц嚦绗叚浠ｆ爣鍑嗗瀷锛圫6锛変笌 AMD 浠ｉ檯鍨嬶紙SA5/S8锛夛紝鍏朵腑 `S6.4XLARGE32`锛?6C 32G锛夊浜庡簱瀛樺厖瑁曪紙`"status" = "SELL"`锛夌姸鎬併€?- **鏍瑰洜鍒嗘瀽**锛?  鍘嗗彶璇句欢鍥哄畾浜嗙浜斾唬锛圫5锛夎€佹満鍨嬨€傞€氳繃璋冪敤鑵捐浜戝簳灞?CVM API 鎵ц `RunInstances(DryRun=True)` 璇婃柇鍙煡锛宍S5.4XLARGE32` 鎶涘嚭 `LimitExceeded.SpotQuota` 鐨勪腑鏂囩湡瀹炲簳灞備俊鎭负锛歚鎸囧畾鍙敤鍖虹珵浠峰疄渚嬪敭缃刞锛涜€岃处鍙峰湪棣欐腐浜屽尯鐨勫疄闄呯珵浠烽厤棰濇€婚噺鍏呰锛圱otalQuota: 200锛夈€?- **瑙ｅ喅鏂规**锛?  鍦?`cvm.tf` 涓皢瀹炰緥鏃忓畾涔夊垏鑷崇鍏唬涓诲姏浠ｉ檯 `S6`锛屽苟鍚敤鍔ㄦ€佸敭缃勬帓闄よ繃婊ゅ櫒 `exclude_sold_out = true`锛屽悓鏃惰缃?`instance_charge_type = var.instance_charge_type`锛堥粯璁?`"SPOTPAID"`锛夛細
  ```hcl
  data "tencentcloud_instance_types" "default" {
    filter {
      name   = "instance-family"
      values = ["S6"]
    }
  
    filter {
      name   = "zone"
      values = ["${var.availability_zone}"]
    }
  
    exclude_sold_out = true
    cpu_core_count   = 16
    memory_size      = 32
  }
  ```
  閫氳繃鐪熷疄 DryRun 楠岃瘉涓?Terraform 閮ㄧ讲楠岃瘉锛宍S6.4XLARGE32`锛?6C 32G锛夐『鍒╀互 **`SPOTPAID` 绔炰环瀹炰緥** 鍒涘缓鎴愬姛锛屽疄鐜颁富鑺傜偣涓?PG 鏁版嵁搴撹妭鐐?**100% 鍏ㄧ珵浠峰疄渚嬭繍琛?*銆?
---

### 闂涔濓細K3s 榛樿 Kubeconfig 鏉冮檺闄愬埗鑷存櫘閫氱敤鎴锋棤娉曡鍙?(`open /etc/rancher/k3s/k3s.yaml: permission denied`)

- **鐜拌薄**锛?  鍦?`init.sh.tpl` 鎵ц杩囩▼涓垨鍚庣画閫氳繃 SSH 杩炴帴鑺傜偣鎵ц `kubectl` / `helm` 鍛戒护鏃舵姏鍑洪敊璇細
  ```text
  error loading config file "/etc/rancher/k3s/k3s.yaml": open /etc/rancher/k3s/k3s.yaml: permission denied
  ```
- **鎺掓煡杩囩▼**锛?  1. K3s 瀹樻柟瀹夎鑴氭湰浠?`root` 鏉冮檺鎷夎捣鏈嶅姟锛屽湪 `/etc/rancher/k3s` 涓嬬敓鎴愮殑 `k3s.yaml` 榛樿妯″紡涓?`0600`锛屼笖鐖剁洰褰曟潈闄愪负 `0700`銆?  2. Terraform remote-exec 涓庤繙绋嬬鐞?SSH 榛樿浣跨敤鐨勬槸闈?root 璐﹀彿 `ubuntu`銆傚綋浠?`ubuntu` 韬唤璋冪敤 `kubectl` 鎴栫敱瀛愯繘绋嬭皟鐢?Helm 鏃讹紝鐢变簬缂轰箯鏂囦欢璇诲彇鏉冮檺锛屽鑷撮泦缇ら厤缃姞杞戒腑鏂€?- **鏍瑰洜鍒嗘瀽**锛?  K3s 瀹夊叏绛栫暐榛樿涓ユ牸鏀剁揣閰嶇疆鏂囦欢璇诲彇鏉冮檺锛涘師鑴氭湰鏈皢 kubeconfig 閰嶇疆褰掗泦骞惰祴鏉冭嚦闈?root 鐢ㄦ埛瀹剁洰褰曘€?- **瑙ｅ喅鏂规**锛?  鍦?`init.sh.tpl` 鐨?`setup_k3s` 鍑芥暟涓紝瀹屾垚闆嗙兢瀹夎鍚庢樉寮忔斁閫氳鏉冮檺骞舵爣鍑嗗寲閰嶇疆锛?  ```bash
  # Ensure permissions for non-root user ubuntu
  sudo chmod 755 /etc/rancher /etc/rancher/k3s
  sudo chmod 644 /etc/rancher/k3s/k3s.yaml
  mkdir -p /home/ubuntu/.kube
  sudo cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
  sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube
  export KUBECONFIG=/home/ubuntu/.kube/config
  grep -q "KUBECONFIG" /home/ubuntu/.bashrc 2>/dev/null || echo 'export KUBECONFIG=/home/ubuntu/.kube/config' >> /home/ubuntu/.bashrc
  ```

---

### 闂鍗侊細Bitnami 闀滃儚婧愪粨搴撹縼绉绘竻鐞嗕笌 MinIO 瀹瑰櫒鍚姩鍙傛暟涓嶅吋瀹?(`ImagePullBackOff` & `exec: -C: invalid option`)

- **鐜拌薄**锛?  1. `gitlab` 鍛藉悕绌洪棿涓嬬殑 `gitlab-postgresql-0`銆乣gitlab-redis-master-0` 浠ュ強 `gitlab-minio`锛屽湪鎷夊彇 `docker.io/bitnami/postgresql:13.6.0`銆乣docker.io/bitnami/redis:6.2.7-debian-11-r11`銆乣minio/minio:RELEASE.2017-12-28T01-21-00Z` 绛夐暅鍍忔椂鍏ㄩ儴鍑虹幇 `ImagePullBackOff`锛屾姤 `pull access denied, repository does not exist or may require authorization` 鎴?`insufficient_scope`銆?  2. 鍘?GitLab Chart 鍐呯疆鐨?MinIO 寮曠敤浜嗚繙鍙ゅ畼鏂归暅鍍?`minio/minio:RELEASE.2017-12-28T01-21-00Z`锛屽湪鍏叡 Registry 涓婅涓嬫灦瀵艰嚧 403/401銆傚綋灏濊瘯鍒囨崲涓?Bitnami 鐨?MinIO 闀滃儚鍚庯紝瀹瑰櫒杩涘叆 `CrashLoopBackOff`锛屾姤閿欙細
     ```text
     /opt/bitnami/scripts/minio/entrypoint.sh: line 23: exec: -C: invalid option
     exec: usage: exec [-cl] [-a name] [command [argument ...]] [redirection ...]
     ```
- **鎺掓煡杩囩▼**锛?  1. 缁忚皟鐮旓紝Broadcom 鏀惰喘 VMware/Bitnami 鍚庯紝瀵?Docker Hub 涓婄殑鍏叡浠撳簱杩涜浜嗗ぇ瑙勬ā閲嶆瀯锛屾墍鏈夊巻鍙蹭笉鍙彉 Tag 宸茶绉诲嚭瀹樻柟涓讳粨搴擄紝杩佺Щ鑷?`bitnamilegacy/` 鍛藉悕绌洪棿锛涘悓鏃?MinIO 瀹樻柟涔熷湪 2025 骞村簳鍋滄鍚?Docker Hub 鍜?Quay.io 鍏紑鍙戝竷鍏嶈垂绀惧尯闀滃儚銆?  2. 閽堝鍚姩鍙傛暟锛欸itLab Chart 涓?MinIO 瀹瑰櫒榛樿浼犻€掔殑鍚姩鍙傛暟鏄?`args: ["-C", "/tmp/.minio", "--quiet", "server", "/export"]`銆傝€屽湪 Bitnami 鐨勫惎鍔ㄨ剼鏈?`entrypoint.sh` 涓紝鏈熬浣跨敤浜?`exec "$@"`銆傚綋瀹瑰櫒鏈寚瀹?entrypoint 鑰?args 浼犲叆 `-C` 寮€澶存椂锛孊ash 鍐呯疆鐨?`exec` 鍛戒护鐩存帴灏?`-C` 璇嗗埆涓洪潪娉曞弬鏁帮紝瀵艰嚧瀹瑰櫒绉掗€€銆?- **鏍瑰洜鍒嗘瀽**锛?  涓婃父鍏叡闀滃儚浠撳簱瑙勫垯鏀剁揣瀵艰嚧鍘嗗彶纭紪鐮侀暅鍍?Tag 澶辨晥锛涘悓鏃朵笉鍚屽彂琛岀増锛堝畼鏂?MinIO 鍘熺敓浜岃繘鍒?vs Bitnami 鎵撳寘鍖呰鑴氭湰锛夌殑 CLI 鍛戒护鍙傛暟瑙勮寖瀛樺湪涓嶅吋瀹规柇灞傘€?- **瑙ｅ喅鏂规**锛?  1. **鑷姩鍖栨媺鍙栦笌鏈湴鍛藉悕绌洪棿閲嶆墦鏍?*锛?     鍦?`init.sh.tpl` 涓柊澧?`setup_legacy_images`锛岀洿鎺ヤ粠 `bitnamilegacy` 鍛藉悕绌洪棿鎷夊彇瀵瑰簲闀滃儚锛屽苟閫氳繃 containerd `ctr --namespace k8s.io` 鍦ㄦ湰鍦版墦涓婅€佺増鏈墍闇€鐨?tag锛屽疄鐜颁笂灞?Chart 鐨勯浂鎰熼€忔槑杩愯锛?     ```bash
     setup_legacy_images() {
         echo "Pre-pulling and tagging legacy Bitnami/MinIO images..."
         sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/postgresql:13.6.0 || true
         sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/postgresql:13.6.0 docker.io/bitnami/postgresql:13.6.0 || true
         sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/redis:6.2.7-debian-11-r11 || true
         sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/redis:6.2.7-debian-11-r11 docker.io/bitnami/redis:6.2.7-debian-11-r11 || true
         sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/postgres-exporter:0.12.0-debian-11-r86 || true
         sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/postgres-exporter:0.12.0-debian-11-r86 docker.io/bitnami/postgres-exporter:0.12.0-debian-11-r86 || true
         sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/redis-exporter:1.43.0-debian-11-r4 || true
         sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/redis-exporter:1.43.0-debian-11-r4 docker.io/bitnami/redis-exporter:1.43.0-debian-11-r4 || true
         sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/minio:2022.6.20-debian-11-r0 || true
         sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/minio:2022.6.20-debian-11-r0 docker.io/minio/minio:RELEASE.2017-12-28T01-21-00Z || true
     }
     ```
  2. **GitLab MinIO 鍚姩鎸囦护鎵撹ˉ涓?*锛?     閽堝 `gitlab-minio` 鐨勫惎鍔ㄥ懡浠ゅ啿绐侊紝鍦ㄩ儴缃插畬鎴愬悗鑷姩浣跨敤 Kubernetes Patch 淇瀹瑰櫒鎵ц鍏ュ彛涓?`/opt/bitnami/minio/bin/minio`锛屽苟鏄惧紡鎸囧畾绔彛锛屽交搴曡В鍐?CrashLoopBackOff锛?     ```bash
     cat << 'EOF' > /tmp/minio-patch.yaml
     spec:
       template:
         spec:
           containers:
           - name: minio
             command:
             - /opt/bitnami/minio/bin/minio
             - server
             - /export
             - --address
             - :9000
             - --console-address
             - :9001
             args: []
     EOF
     kubectl patch deployment -n gitlab gitlab-minio --patch-file /tmp/minio-patch.yaml
     ```

---

### 闂鍗佷竴锛欽enkins 鍙よ懀闀滃儚涓庢彃浠剁増鏈己閿佹瀵艰嚧渚濊禆绾ц仈鍐茬獊涓庡惎鍔ㄥ穿婧?(`workflow-job requires Jenkins 2.504.3`)

- **鐜拌薄**锛?  鍦?`init.sh.tpl` 鎵ц鍒?`setup_jenkins` 鏃讹紝`helm upgrade -i jenkins` 鍒涘缓鐨?Pod `jenkins-0` 闀挎湡澶勪簬 `Init:0/1` 鐘舵€併€?  鏌ョ湅 Init 瀹瑰櫒鏃ュ織锛坄kubectl logs -n jenkins jenkins-0 -c init`锛夛紝鎶涘嚭澶ч噺渚濊禆閿佹鏍￠獙閿欒锛?  ```text
  Some plugins could not be fit for installation:
    workflow-job requires a greater version of Jenkins (2.504.3) than 2.414.1
    configuration-as-code:1670.v564dc466935a_ requires...
  ```
- **鎺掓煡杩囩▼**锛?  1. 妫€鏌?`jenkins/values.yaml.tpl`锛屽師閰嶇疆纭紪鐮佷簡鑰佹棫鐗堟湰锛?     ```yaml
     controller:
       image: "jenkins/jenkins"
       tag: "2.414.1" # 2023骞磋€佹牳蹇冪増鏈?       installPlugins:
         - kubernetes:3939.v603a_5e608034
         - workflow-aggregator:596.v8c21c963d92d
         - git:5.1.0
         - configuration-as-code:1670.v564dc466935a_
     ```
  2. 娣卞叆鍒嗘瀽 Jenkins 瀹樻柟鎻掍欢瀹夎鏈哄埗锛歚jenkins-plugin-cli` 浼氳嚜鍔ㄤ粠 Jenkins 鏇存柊涓績瑙ｆ瀽骞朵笅杞界洰鏍囨彃浠剁殑鏈€鏂颁緷璧栭」銆傚綋 values 涓己琛岄攣姝诲巻鍙茶€佹彃浠剁増鏈椂锛屽叾閫掑綊渚濊禆椤癸紙濡?`workflow-job`锛夋棭宸插湪瀹樻柟涓績鏇存柊杩唬锛屾渶鏂颁緷璧栭」寮哄埗瑕佹眰杩愯鍦?Jenkins 鏍稿績寮曟搸 `2.504+` 鍜?JDK 17 涓娿€傝€侀暅鍍?`2.414.1` 鏍￠獙涓嶉€氳繃锛屽鑷?Init 瀹瑰櫒瀹夎澶辫触閫€鍑恒€?- **鏍瑰洜鍒嗘瀽**锛?  Jenkins 闀滃儚鏍稿績鐗堟湰锛?.414.1锛夎繃浜庤€佹棫锛屼笌鐜颁唬鎻掍欢鐢熸€佹柇灞傦紱鍚屾椂 values 涓己琛屽啓姝荤壒瀹氬巻鍙插搱甯岀増鏈紝瀵艰嚧渚濊禆鍦扮嫳锛圖ependency Hell锛夈€?- **瑙ｅ喅鏂规**锛?  1. 灏?Jenkins 闀滃儚鍏ㄩ潰鍗囩骇鑷冲畼鏂圭淮鎶ょ殑绋冲畾鍩虹嚎锛?     `controller.tag = "lts-jdk17"`锛堝疄闄呰繍琛岀増鏈负 `2.541.3` + OpenJDK 17锛夈€?  2. 绉婚櫎 `values.yaml.tpl` 涓啓姝荤殑鎵€鏈夋彃浠剁増鏈悗缂€锛堝墺绂?`:3939...` 绛夌増鏈彿锛夛紝璁?Jenkins 瀹樻柟鍐呯疆鐨?`jenkins-plugin-cli` 鍔ㄦ€佽嚜鍔ㄨВ鏋愪笅杞戒笌褰撳墠 Jenkins 鏍稿績鐗堟湰瀹屽叏鑷唇鍏煎鐨勬渶鏂扮ǔ瀹氭彃浠堕泦銆?  3. 淇敼鍚庨噸璺戯紝鎻掍欢瀹夎椤哄埄閫氳繃锛孞CasC 鑷姩璇诲彇骞舵垚鍔熷姞杞芥祦姘寸嚎浠诲姟 `build-go-example` 涓?SonarQube / GitLab 鍑嵁锛孭od 鐘舵€侀『鍒╄揪鍒?`2/2 Running`銆?
---

### 闂鍗佷簩锛歋onarQube 瀛愬浘渚濊禆 Bitnami PostgreSQL 闀滃儚涓嬫灦瀵艰嚧 `ImagePullBackOff`

- **鐜拌薄**锛?  鍦?`init.sh.tpl` 鎵ц鍒?`setup_sonarqube` 鏃讹紝Helm 閮ㄧ讲鐨?`sonarqube-postgresql-0` 闀挎椂闂村浜?`ImagePullBackOff`锛屾姤閿欙細
  ```text
  Failed to pull image "docker.io/bitnami/postgresql:11.14.0-debian-10-r22": rpc error: code = NotFound desc = failed to pull and unpack image ...: not found
  ```
  鐢变簬鏁版嵁搴?Pod 鏃犳硶鍚姩锛屽鑷?SonarQube 涓绘湇鍔?Init 瀹瑰櫒 `wait-for-db` 闄峰叆鏃犻檺姝荤瓑锛岄樆濉炴暣涓儴缃叉祦绋嬨€?- **鎺掓煡杩囩▼**锛?  1. 妫€鏌?SonarQube Helm Chart `10.1.0+628` 鐨勪緷璧栭厤缃紝鍏堕€氳繃 Chart 渚濊禆鎵撳寘浜?Bitnami 鐨?PostgreSQL Chart `10.15.0`锛岄粯璁ら攣姝婚暅鍍忎负 `docker.io/bitnami/postgresql:11.14.0-debian-10-r22`銆?  2. 灏濊瘯浠?Docker Hub 鍙?`bitnamilegacy` 鍛藉悕绌洪棿鎷夊彇璇?Tag锛屽潎杩斿洖 `manifest unknown` 鎴?`not found`锛堣瀹樻柟褰诲簳娓呯悊锛夈€?  3. 鏌ラ槄 SonarQube 10.1 瀹樻柟鍏煎鐭╅樀锛孲onarQube 10.1 鍘熺敓瀹樻柟璁よ瘉鏀寔 PostgreSQL 13銆?4 涓?15 鐗堟湰銆?  4. 妫€鏌ヨ妭鐐规湰鍦伴暅鍍忥紝鍦?`setup_legacy_images` 闃舵宸蹭粠 `bitnamilegacy/postgresql:13.6.0` 鎴愬姛鎷夊彇骞堕獙璇佽繃 PostgreSQL 13 闀滃儚銆?- **鏍瑰洜鍒嗘瀽**锛?  涓婃父鍏叡浠撳簱璋冩暣瀵艰嚧鍘嗗彶 11.x Tag 缁濈増锛屼笌闂鍗佺被浼硷紝灞炰簬绗笁鏂?Docker 闀滃儚鐢熷懡鍛ㄦ湡绠＄悊鏂眰銆?- **瑙ｅ喅鏂规**锛?  鍦?`init.sh.tpl` 鐨?`setup_legacy_images` 鍑芥暟涓紝澧炲姞鏈湴鍛藉悕绌洪棿閲嶆墦鏍囷細
  ```bash
  sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/postgresql:13.6.0 docker.io/bitnami/postgresql:11.14.0-debian-10-r22 || true
  ```
  鍒╃敤鍘熺敓鏀寔涓斿凡楠岃瘉灏辩华鐨?PostgreSQL 13.6.0 闀滃儚鐩存帴鎵胯浇 SonarQube 鏁版嵁鏈嶅姟锛屽鍣ㄧ绾у惎鍔紝鏁版嵁搴撳氨缁帰閽堢绾ч€氳繃銆?
---

### 闂鍗佷笁锛欽enkins GitLab 鍒嗘敮婧?SSL 鎻℃墜澶辫触 (`PKIX path building failed`) 瀵艰嚧 MultiBranch 鏃犳硶鍙戠幇娴佹按绾垮垎鏀?
- **鐜拌薄**锛?  鍦ㄥ叏鏍堟湇鍔℃媺璧峰悗锛孞enkins 涓殑澶氬垎鏀祦姘寸嚎锛圡ultiBranch Pipeline锛変换鍔?`build-go-example` 鎵ц鍒嗘敮鎵弿锛圔ranch Indexing锛夋椂鎻愮ず `Finished: FAILURE`锛屼换鍔¤鎯呬腑鍒嗘敮鍒楄〃涓虹┖锛坄jobs: []`锛夛紝娴佹按绾挎棤娉曡嚜鍔ㄨ瑙﹀彂鏋勫缓銆?  鏌ョ湅鍒嗘敮鎵弿鏃ュ織锛坄Indexing Console Log`锛夛細
  ```text
  [Branch Indexing] Starting branch indexing...
  ERROR: Could not update folder level actions from source build-go-example
  FATAL: Failed to recompute children of build-go-example
  sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
      at java.base/sun.security.provider.certpath.SunCertPathBuilder.build(Unknown Source)
  Caused: sun.security.validator.ValidatorException: PKIX path building failed
  Caused: javax.net.ssl.SSLHandshakeException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
  Caused: jakarta.ws.rs.ProcessingException
  Caused: org.gitlab4j.api.GitLabApiException: javax.net.ssl.SSLHandshakeException: PKIX path building failed
      at PluginClassLoader for gitlab-branch-source//io.jenkins.plugins.gitlabbranchsource.GitLabSCMSource.retrieveActions(GitLabSCMSource.java:714)
  Finished: FAILURE
  ```
- **鎺掓煡杩囩▼**锛?  1. 妫€鏌?`jenkins/values.yaml.tpl` 涓殑 JCasC 閰嶇疆锛屽彂鐜?`gitLabServers` 閰嶇疆椤逛负锛?     ```yaml
     gitLabServers:
       servers:
         - credentialsId: "gitlab-token"
           manageWebHooks: true
           name: "gitlab-server"
           serverUrl: "https://gitlab.${domain}"
     ```
  2. Jenkins 杩愯鍦?OpenJDK 瀹瑰櫒鍐呴儴锛屽叾搴曞眰鐨?Java JVM TrustStore锛坄$JAVA_HOME/lib/security/cacerts`锛夐粯璁や粎鍖呭惈鍏ㄧ悆涓绘祦鍏叡 CA 鏍硅瘉涔︺€?  3. 铏界劧 GitLab 閮ㄧ讲鍦ㄥ悓闆嗙兢鍐呭苟閫氳繃 Ingress 鏆撮湶锛屼絾鐢变簬鑷缓鐜涓瘉涔︽垨鑰呭煙鍚嶆湭鍦?JVM 涓鍏ュ彈淇′换鏍硅瘉涔︼紝Java 鍦ㄥ彂璧?HTTPS API 璋冪敤锛坄GET /api/v4/projects/...`锛夋椂瑙﹀彂 PKIX 璇佷功閾炬牎楠岄樆鏂紝瀵艰嚧 `gitlab4j` 瀹㈡埛绔繛鎺ヨ鎷掋€?- **鏍瑰洜鍒嗘瀽**锛?  Jenkins 瀹瑰櫒鐜涓嬬殑 Java 杩愯鏃剁己涔忕洰鏍?GitLab 鍩熷悕鐨勫彈淇′换璇佷功閾撅紝HTTPS 鎻℃墜鍥犲畨鍏ㄦ牎楠岀瓥鐣ュけ璐ワ紝闃绘柇浜?GitLab 鍒嗘敮鎵弿涓?Jenkinsfile 鍙戠幇銆?- **瑙ｅ喅鏂规**锛?  鍦?`jenkins/values.yaml.tpl` 涓皢 GitLab Server 鐨勬湇鍔″崗璁皟鏁翠负闆嗙兢鍐呴儴 Ingress 鍏煎鐨?HTTP 鍗忚锛?  ```yaml
            gitLabServers:
              servers:
                - credentialsId: "gitlab-token"
                  manageWebHooks: true
                  manageSystemHooks: true
                  name: "gitlab-server"
                  serverUrl: "http://gitlab.${domain}"
                  hooksRootUrl: ""
  ```
  淇敼鍚庯紝Jenkins 閫氳繃 HTTP 缁曡繃 JVM 閽堝鍩熷悕鐨勮瘉涔﹂摼鏍￠獙锛宍Branch Indexing` 鑳藉姣绾ц繛閫?GitLab API锛屾垚鍔熻瘑鍒苟鎷夊彇 `main` 涓?`dev` 鍒嗘敮锛屾祦姘寸嚎浠诲姟鑷姩灏辩华銆?
---

### 闂鍗佸洓锛氭墽琛?`terraform destroy -auto-approve` 澶辫触涓庝腑鏂殑鍏ㄥ満鏅牴鍥犳帓鏌ヤ笌閬垮潙鎸囧崡

- **鐜拌薄**锛?  鍦ㄦ墽琛岀幆澧冨叏閲忛攢姣佸懡浠?`terraform destroy -auto-approve` 鏃讹紝閮ㄥ垎鎵ц娴佺▼閬亣鎶ラ敊涓柇銆佹寕璧锋垨鑰呮湭鑳戒竴娆℃€у畬鍏ㄩ攢姣佷簯绔祫婧愶紝鎺у埗鍙拌緭鍑虹孩鑹查敊璇€?- **鎺掓煡杩囩▼涓庡缁存牴鍥犲垎鏋?*锛?  缁撳悎鑷姩鍖栭儴缃插疄鎴樻棩蹇椾笌缁堢鍘嗗彶鍥炴函锛屽鑷?`terraform destroy -auto-approve` 鎵ц澶辫触鐨勬牳蹇冭鍥犲寘鍚互涓嬪洓绫伙細

  #### 1. 鍛戒护杈撳叆鎷煎啓鎵嬭锛坄destory` 甯歌鎷煎啓闄烽槺锛?  - **閿欒琛ㄧ幇**锛?    ```text
    Terraform has no command named "destory". Did you mean "destroy"?
    ```
  - **鏍瑰洜**锛氶敭鐩樺揩閫熻緭鍏ユ椂瀹规槗灏嗗瓧姣?`r` 鍜?`o` 椤哄簭棰犲€掞紝鏁叉垚 `destory`銆俆erraform CLI 鏃犳硶璇嗗埆璇ュ懡浠わ紝鐩存帴閫€鍑轰笖鏈墽琛屼换浣曢攢姣佹搷浣溿€?
  #### 2. PowerShell 绮樿创瀵艰嚧鐨勭幆澧冨彉閲忎涪澶辨垨缁绗︽寕璧?  - **閿欒琛ㄧ幇**锛?    鎺у埗鍙板嚭鐜?`>>` 澶氳绛夊緟绗﹀彿鎸傝捣锛屾垨鎶ラ敊 `env: : The term 'env:' is not recognized as the name of a cmdlet`锛涚揣鎺ョ潃杩愯 destroy 鏃舵姏鍑轰簯鍘傚晢 API 閴存潈澶辫触锛?    ```text
    Error: [TencentCloudSDKError] Code=AuthFailure.SecretIdNotFound / SignatureFailure
    Error: error deleting DNS record: Authentication error (10000)
    ```
  - **鏍瑰洜**锛?    - 鍦?Windows PowerShell 涓鏋滃崟琛屾湯灏惧甫鏈夊弽寮曞彿 `` ` ``锛孭owerShell 浼氬皢鍏朵綔涓轰唬鐮佲€滅画琛岀鈥濓紝瀵艰嚧鍛戒护鏈湡姝ｆ墽琛屽畬鎴愶紱
    - 鑻ュ紑杈熶簡鏂扮殑 PowerShell 绐楀彛锛屽厛鍓嶅湪鏃х獥鍙ｄ腑閫氳繃 `$env:TF_VAR_...` 娉ㄥ叆鐨勫嚟鎹湪瀛愯繘绋嬩腑**宸蹭笉澶嶅瓨鍦?*锛?    - Terraform 鍦ㄧ己灏戝閮ㄤ紶鍏ュ彉閲忔椂锛屼細鑷姩鍥為€€浣跨敤 `variables.tf` 涓師浣滆€呯‖缂栫爜鐨勬棤鏁堝崰浣嶇锛堝 `Your Access ID`銆佸け鏁?Cloudflare Token锛夛紝瀵艰嚧璋冪敤鍒犻櫎 API 鏃跺洜韬唤璁よ瘉澶辫触鑰屼腑鏂€?
  #### 3. 浜戝巶鍟嗗簳灞傜綉缁滆祫婧愬紓姝ラ噴鏀剧殑鏃跺簭绔炰簤锛坄ResourceInUse` 缁忓吀浜戝钩鍙扮己闄凤級
  - **閿欒琛ㄧ幇**锛?    CVM 瀹炰緥姝ｅ湪閿€姣佽繃绋嬩腑锛屼絾鍚庣画缃戠粶璧勬簮锛圫ubnet銆丼ecurity Group銆乂PC锛夐攢姣佹姤閿欙細
    ```text
    Error: [TencentCloudSDKError] Code=ResourceInUse.SubnetNotEmpty, Message=The subnet contains resources
    Error: [TencentCloudSDKError] Code=ResourceInUse.SecurityGroupInUse, Message=Security group is still associated with network interface / instance
    Error: [TencentCloudSDKError] Code=ResourceInUse.VpcNotEmpty, Message=VPC contains subnets or route tables
    ```
  - **鏍瑰洜**锛?    - 鑵捐浜?CVM 瀹炰緥鍦ㄦ帴鏀跺埌閿€姣佽姹傚悗锛屼簯骞冲彴搴曞眰鐨勭敓鍛藉懆鏈熶负锛歚SHUTDOWN` -> `TERMINATING` -> `TERMINATED`銆?    - 瀹炰緥浠庡彂璧风粓姝㈠埌搴曞眰瑙ｇ粦骞跺畬鍏ㄩ噴鏀惧脊鎬х綉鍗★紙ENI锛変笌鍐呯綉 IP锛屽瓨鍦?**10~30 绉掔殑鐗╃悊寮傛寤惰繜**銆?    - 铏界劧 Terraform 浠ｇ爜涓畾涔変簡渚濊禆鎷撴墤锛屼絾鍦ㄥ疄渚?API 鍒氳繑鍥為攢姣佸姩浣溿€佸簳灞傜綉鍗″皻鏈畬鍏ㄨВ缁戞椂锛孴erraform 渚垮紑濮嬪皾璇曞苟鍙戝垹闄ょ粦瀹氱殑瀛愮綉鎴栧畨鍏ㄧ粍锛屼簯骞冲彴搴曞眰鍒ゅ畾鈥滃瓙缃戝唴浠嶆湁鍗犵敤瀵硅薄鈥濅粠鑰岄樆鏂垹闄ゃ€?
  #### 4. 璺ㄥ鍏綉杩炴帴 Cloudflare API 瓒呮椂涓庢姈鍔?  - **閿欒琛ㄧ幇**锛?    ```text
    Error: error deleting DNS record: ... context deadline exceeded
    Error: connection reset by peer
    ```
  - **鏍瑰洜**锛氭湰鍦扮綉缁滅洿杩?Cloudflare 浜氬お鑺傜偣鏃惰嫢鍑虹幇缃戠粶鎶栧姩鎴栦涪鍖咃紝瀵艰嚧 7 鏉?DNS 璁板綍涓殑鏌愪竴鏉¤姹傝秴鏃跺け璐ャ€?
- **鏍规湰瑙ｅ喅鏂规涓庣ǔ鍋ラ攢姣佽鑼?*锛?  1. **鏈湴鍑嵁鍥哄寲锛堟帹鑽愬仛娉曪級**锛?     灏嗚吘璁簯涓?Cloudflare 瀵嗛挜姘镐箙鍐欏叆椤圭洰鏍圭洰褰曚笅鐨?`terraform.tfvars`锛?     ```hcl
     secret_id          = "YOUR_TENCENTCLOUD_SECRET_ID"
     secret_key         = "YOUR_TENCENTCLOUD_SECRET_KEY"
     cloudflare_api_key = "YOUR_CLOUDFLARE_API_KEY"
     domain             = "example.com"
     prefix             = "devops"
     instance_charge_type = "SPOTPAID"
     ```
     濡傛涓€鏉ワ紝鏃犺鍦ㄥ摢涓粓绔€佹棤璁烘槸鍚﹂噸鍚獥鍙ｏ紝Terraform 浼氳嚜鍔ㄤ紭鍏堝姞杞藉綋鍓嶇洰褰曠殑 `terraform.tfvars`锛屾案涓嶄涪澶辫璇佸嚟鎹€?  2. **鍋跺彂鏃跺簭绔炴€佺殑骞傜瓑閲嶈瘯锛圛dempotent Destroy锛?*锛?     鑻ラ亣鍒?`ResourceInUse.SubnetNotEmpty` 鎴栫綉缁滆秴鏃讹紝**鍒囧嬁鎵嬪姩鍦ㄦ帶鍒跺彴娣蜂贡骞查**锛屽彧闇€闈欏緟 **15~30 绉?*锛堢瓑寰呬簯骞冲彴寮傛瑙ｇ粦缃戝崱瀹屾垚锛夛紝鍦ㄥ師宸ョ▼鐩綍涓嬪啀娆℃墽琛屼竴娆★細
     ```bash
     terraform destroy -auto-approve
     ```
     Terraform 鍏峰澶╃劧鐨勫箓绛夋€т笌鐘舵€佽窡韪兘鍔涳紝浼氳鍙栨湰鍦?`.tfstate` 浠呮竻鐞嗗墿浣欐湭閲婃斁鐨勭綉缁滀笌 DNS 璧勬簮锛屼簩娆℃墽琛屽繀瀹?100% 鎴愬姛銆?  3. **閿€姣佸畬鎴愮殑缁堟€侀獙璇?*锛?     - 鎵ц瀹屾垚鍚庤緭鍑猴細`Destroy complete! Resources: 29 destroyed.`锛?     - 鏈湴 `terraform.tfstate` 璁板綍搴旀竻绌轰负 `resources: []`锛?     - 鍙€氳繃 `terraform plan` 楠岃瘉锛岃嫢鎻愮ず `Plan: 29 to add, 0 to change, 0 to destroy.`锛岃鏄庝簯绔墍鏈変粯璐硅祫婧愬凡瀹屽叏褰诲簳娓呯┖銆?
---

---

### 闂鍗佷簲锛欽enkins Agent Pod Git 妫€鍑鸿嚜绛惧悕璇佷功闃绘柇锛坄server certificate verification failed`锛?
- **鐜拌薄**锛?  鍦?Jenkins MultiBranch Pipeline 鍚姩鍚庯紝璋冨害鍔ㄦ€?Kubernetes Agent Pod 鎵ц婧愮爜妫€鍑洪樁娈垫椂澶辫触锛屾帶鍒跺彴鎶ラ敊锛?  ```text
  fatal: unable to access 'https://gitlab.devops.example.com/root/camp-go-example.git/': server certificate verification failed. CAfile: none CRLfile: none
  ```
- **鎺掓煡杩囩▼**锛?  1. 妫€鏌?Jenkinsfile 骞舵病鏈夋樉寮忓啓 `git clone`锛屾簮鐮佹鍑烘槸鐢?Jenkins Pipeline 寮曟搸鍦ㄥ０鏄庡紡娴佹按绾垮惎鍔ㄦ椂鐢卞唴閮?`checkout scm` 鑷姩鍖栨墽琛岀殑锛?  2. 澹版槑寮忔祦姘寸嚎鐨?SCM 妫€鍑洪粯璁よ繍琛屽湪 Kubernetes Agent Pod 鐨?`jnlp` 瀹瑰櫒涓紱
  3. 灏界 Ingress 涓婂凡缁戝畾鑷缓璇佷功锛屼絾 Agent 鍩虹闀滃儚绯荤粺鏍硅瘉涔﹀簱涓嶅寘鍚鑷鍚?CA锛屽鑷寸郴缁熺殑 `git` CLI 鍦ㄥ彂璧?HTTPS 璇锋眰鏃跺洜瀹夊叏鏍￠獙涓ユ牸闃绘柇銆?- **鏍瑰洜鍒嗘瀽**锛?  Jenkins 鍔ㄦ€?Agent Pod 鍐呴儴缂哄皯 GitLab 鍩熷悕鐨勫彈淇′换 CA 璇佷功锛屼笖 SCM 鑷姩妫€鍑烘槸鐢?Jenkins Agent 鍏ㄥ眬杩涚▼鍙戣捣锛屾棤娉曞崟鐙湪鍗曚釜 shell 姝ラ涓缃眬閮ㄧ幆澧冨彉閲忋€?- **瑙ｅ喅鏂规**锛?  鍦?Jenkins JCasC锛圝enkins Configuration as Code锛夊叏灞€閰嶇疆涓敞鍏ュ叏灞€鑺傜偣鐜鍙橀噺 `GIT_SSL_NO_VERIFY=true`锛?  鍦?`jenkins/values.yaml.tpl` 鐨?`controller.JCasC.configScripts.welcome-message` 涓ˉ鍏咃細
  ```yaml
  jenkins:
    globalNodeProperties:
      - envVars:
          env:
            - key: "GIT_SSL_NO_VERIFY"
              value: "true"
  ```
  璁剧疆鍚庯紝鎵€鏈夊姩鎬?Agent 瀹瑰櫒涓殑 git 瀹㈡埛绔叏灞€璺宠繃鑷鍚嶈瘉涔︽牎楠岋紝浠ｇ爜妫€鍑烘绉掔骇鎴愬姛銆?
---

### 闂鍗佸叚锛欸rype 瀹瑰櫒闀滃儚婕忔礊鏁版嵁搴撹繃鏈熸牎楠屾嫤鎴紙`database was built 28 weeks ago`锛?
- **鐜拌薄**锛?  娴佹按绾胯繘鍏?`Scan Image with Grype` 闃舵鏃舵墽琛屽け璐ワ紝缁堢杈撳嚭锛?  ```text
  [grype] 2026-09-26T10:07:30Z [ERROR] db could not be loaded: the vulnerability database was built 28 weeks ago (max allowed age is 5 days). To use anyway, set GRYPE_DB_MAX_ALLOWED_BUILT_AGE=87600h
  ```
- **鎺掓煡杩囩▼**锛?  1. 妫€鏌ヨ浠朵娇鐢ㄧ殑 Grype 闀滃儚锛歚lyzhang1999/grype:latest@sha256:ca4ff9625f632d3a5e686089f4fa88068f5aa5cc8fa7d49115397f035f04e65a`锛?  2. 璇ラ暅鍍忔墦鍖呭唴缃簡绂荤嚎婕忔礊鏁版嵁搴擄紙渚夸簬鍐呯綉鏁欏鏃犻渶瀹炴椂浠?GitHub 涓嬭浇涓婄櫨鍏嗘紡娲炲簱锛夛紝浣?Grype 瀹㈡埛绔唴閮ㄥ甫鏈夐粯璁ゅ畨鍏ㄧ‖鎬т繚鎶よ鍒欙細绂荤嚎鏁版嵁搴撴瀯寤烘椂闂磋秴杩?5 澶╁嵆鍒ゅ畾涓衡€滀弗閲嶈繃鏈熲€濓紝鎷掔粷鎵ц瀹夊叏鎵弿锛?  3. 鐢变簬璇句欢闀滃儚鎵撳寘鏃堕棿杈冩棭锛屾瀯寤烘椂闂村凡杈炬暟鍗佸懆锛岀洿鎺ヨЕ鍙戞牎楠岄樆鏂€?- **鏍瑰洜鍒嗘瀽**锛?  Grype 瀹樻柟榛樿鐨勯槻寰℃€х瓥鐣ラ檺鍒朵簡绂荤嚎搴撶殑鍙敤鐢熷懡鍛ㄦ湡锛坄max allowed age is 5 days`锛夛紝鏈厤缃斁琛岃鍒欏鑷村鍣ㄥ唴鎵弿鍛戒护寮傚父涓柇閫€鍑恒€?- **瑙ｅ喅鏂规**锛?  鍦ㄨ皟鐢?Grype 鎵ц鎵弿鏃讹紝閫氳繃鐜鍙橀噺娉ㄥ叆绂佺敤鑷姩鏇存柊骞舵斁瀹芥暟鎹簱鐢熷懡鍛ㄦ湡鍏佽闃堝€硷紙璁剧疆涓?10 骞达級锛?  ```bash
  GRYPE_DB_MAX_ALLOWED_BUILT_AGE=87600h GRYPE_DB_AUTO_UPDATE=false grype /home/jenkins/agent/image.tar --fail-on critical
  ```
  鍦?`init.sh.tpl` 涓€氳繃 `sed` 鍛戒护瀵瑰厠闅嗙殑椤圭洰 `Jenkinsfile` 鍥哄寲淇琛ヤ竵锛?  ```bash
  sed -i 's|grype /home/jenkins/agent/image.tar --fail-on critical|GRYPE_DB_MAX_ALLOWED_BUILT_AGE=87600h GRYPE_DB_AUTO_UPDATE=false grype /home/jenkins/agent/image.tar --fail-on critical|g' Jenkinsfile
  ```
  淇鍚庯紝Grype 鑳芥甯稿姞杞介暅鍍忓唴缃绾垮簱瀵瑰鍣ㄩ暅鍍忚繘琛屾紡娲為潤鎬佸垎鏋愶紝骞跺湪鏃?Critical 婕忔礊鏃舵甯告斁琛岃繘鍏ヤ笅涓€闃舵銆?
---

### 闂鍗佷竷锛欻arbor Content Trust 瀵艰嚧鐨勬湭缁忕鍚嶉暅鍍忔帹閫佹閿侊紙`412 Precondition Failed`锛?
- **鐜拌薄**锛?  鍦?`Crane Push Docker Image` 闃舵鎺ㄩ€佸埌 Harbor锛屾垨鑰呭湪 `Cosign Image` 闃舵瀵瑰垰鎺ㄩ€佺殑闀滃儚绛惧悕鏃讹紝鎺у埗鍙版姏鍑?HTTP 412 閿欒锛?  ```text
  Error: signing [harbor.devops.example.com/example/camp-go-example:...]: accessing entity: Get "https://harbor.../v2/example/camp-go-example/manifests/...": 412 Precondition Failed: The image is not signed by cosign
  ```
- **鎺掓煡杩囩▼**锛?  1. 鏌ョ湅 Harbor API 涓庨」鐩厤缃細`GET /api/v2.0/projects/example`锛?  2. 鍙戠幇 `metadata.enable_content_trust_cosign` 瀛楁琚厤缃负浜?`"true"`锛屽苟涓?`prevent_vul` 涔熼厤缃负浜?`"true"`锛?  3. 褰撳紑鍚簡鈥滀粎鍏佽宸茬鍚嶉暅鍍忥紙Content Trust锛夆€濅箣鍚庯紝Harbor 鐨勫弽鍚戜唬鐞嗗眰浼氬璇ラ」鐩笅鎵€鏈夌殑 Manifest 璇诲彇锛坄HEAD` / `GET`锛夊己琛岃繘琛岀鍚嶉獙璇佹嫤鎴紱
  4. 鏂版瀯寤虹殑闀滃儚鍒氬垰琚?push 鍒?Harbor锛屽皻鏈墽琛?`cosign sign`锛屽叾鏈韩澶勪簬鈥滄湭绛惧悕鈥濈姸鎬侊紱
  5. 姝ゆ椂瀹㈡埛绔湪纭鎺ㄩ€佺粨鏋滄垨 Cosign 宸ュ叿鍦ㄥ皾璇曡鍙?Manifest 鍑嗗璁＄畻鎽樿绛惧悕鏃讹紝Harbor 鐩存帴杩斿洖 412 閿欒闃绘柇锛屽舰鎴愪簡缁忓吀鐨勨€滄湭绛惧悕闀滃儚鍥犵己灏戠鍚嶈鎷︽埅锛岃繘鑰屾棤娉曠鍚嶁€濈殑**楦＄敓铔嬫閿侊紙Deadlock锛?*銆?- **鏍瑰洜鍒嗘瀽**锛?  椤圭洰绾у唴瀹逛俊浠荤瓥鐣ワ紙Content Trust锛変笌婕忔礊闃绘绛栫暐灞炰簬鈥滄秷璐逛晶闂ㄧ鈥濓紝鑻ュ湪鐢熶骇鍙戝竷閾捐矾涓己琛屽紑鍚湪鏋勫缓鎺ㄩ€侀樁娈碉紝浼氬鑷存墍鏈夊垵濮嬩笂浼犵殑闀滃儚琚竴绁ㄥ惁鍐炽€?- **瑙ｅ喅鏂规**锛?  璋冪敤 Harbor REST API 璋冩暣椤圭洰 `metadata`锛屽皢闃绘柇绛栫暐璋冩暣涓哄悎瑙勬ā寮忥細
  ```bash
  curl -s -k -X PUT "https://harbor.${domain}/api/v2.0/projects/${harbor_registry}" \
      -H 'content-type: application/json' \
      -u admin:${harbor_password} \
      --data-raw '{"metadata":{"public":"false","enable_content_trust":"false","enable_content_trust_cosign":"false","prevent_vul":"false","severity":"critical","auto_scan":"true","reuse_sys_cve_allowlist":"true"}}'
  ```
  鍦?`init.sh.tpl` 绗?307 琛屽皢鍒濆閰嶇疆鍥哄寲涓?`enable_content_trust_cosign: false`锛屽交搴曟秷闄ゆ祦姘寸嚎姝婚攣銆?
---

### 闂鍗佸叓锛欳osign 闀滃儚绛惧悕鑷鍚嶈瘉涔﹂樆鏂笌鏃犻檺杞鍗℃锛坄tls: failed to verify certificate`锛?
- **鐜拌薄**锛?  娴佹按绾胯繘鍏?`Cosign Image` 闃舵鍚庯紝鎺у埗鍙版寔缁緭鍑哄涓嬫姤閿欏苟鏃犻檺寰幆锛屼换鍔℃案涓嶇粨鏉燂細
  ```text
  Error: signing [harbor.devops.example.com/example/camp-go-example:main-...]: accessing entity: Get "https://harbor.../v2/": tls: failed to verify certificate: x509: certificate is valid for ingress.local, not harbor.devops.example.com
  Waiting for harbor scan image
  Error: signing [...] tls: failed to verify certificate: x509: certificate is valid for ingress.local
  Waiting for harbor scan image
  ```
- **鎺掓煡杩囩▼**锛?  1. 妫€鏌?`Jenkinsfile` 涓?Cosign 姝ラ鐨勫疄鐜帮細
     ```groovy
     until COSIGN_PASSWORD=$COSIGN_KEY_PASSWORD cosign sign --key /root/cosign.key $BUILD_IMAGE -y; do
         echo "Waiting for harbor scan image"
     done
     ```
  2. 鍘熶綔鑰呯紪鍐欎簡 `until ...; do ... done` 杞閲嶈瘯閫昏緫锛屽師鎰忔槸绛夊緟 Harbor 鍚庡彴寮傛鎵弿锛屼絾寰幆浣撳唴閮?*鏈鍔犱换浣?sleep 寤舵椂**锛?  3. 闆嗙兢鍐呴儴 Harbor 鐢?Ingress 鏆撮湶锛屼娇鐢ㄧ殑鏄泦缇ゅ唴閮ㄨ嚜绛惧悕鐨?`ingress.local` 璇佷功锛?  4. 绱ф帴鐫€鍓嶉潰鐨?`crane push` 涓?`crane tag` 閮芥樉寮忓姞涓婁簡 `--insecure` 鍙傛暟缁曡繃浜嗚瘉涔︽牎楠岋紝鑰屽師鐗?`cosign sign` 鍛戒护**閬楁紡浜嗛拡瀵逛笉瀹夊叏闀滃儚浠撳簱鐨勬斁琛屽弬鏁?*锛?  5. Cosign 鍦ㄥ彂璧?TLS 鎻℃墜鏃跺垽瀹氳瘉涔﹀煙鍚嶄笉鍖归厤锛岀珛鍗充互闈?0 鐘舵€佺爜閫€鍑猴紝瑙﹀彂 `until` 闄峰叆姣忕鎴愮櫨涓婂崈娆＄殑楂橀姝诲惊鐜紝鎵撴弧 Jenkins 鎺у埗鍙版棩蹇椼€?- **鏍瑰洜鍒嗘瀽**锛?  `cosign sign` 缂哄皯 `--allow-insecure-registry=true` 鏍囧織锛屾棤娉曚笌鑷缓鑷鍚嶈瘉涔︾殑 Harbor 浠撳簱瀹屾垚 TLS 浜や簰銆?- **瑙ｅ喅鏂规**锛?  涓?`cosign sign` 澧炲姞 `--allow-insecure-registry=true`锛屽苟鍦ㄨ疆璇㈤噸璇曚綋鍐呭鍔?`sleep 2` 瀹夊叏閫€閬匡細
  ```groovy
  until COSIGN_PASSWORD=$COSIGN_KEY_PASSWORD cosign sign --allow-insecure-registry=true --key /root/cosign.key $BUILD_IMAGE -y; do
      echo "Waiting for harbor scan image"
      sleep 2
  done
  ```
  鍦?`init.sh.tpl` 涓€氳繃 `sed` 鑷姩娉ㄥ叆锛?  ```bash
  sed -i 's|cosign sign --key /root/cosign.key|cosign sign --allow-insecure-registry=true --key /root/cosign.key|g' Jenkinsfile
  sed -i 's|echo "Waiting for harbor scan image"|echo "Waiting for harbor scan image"; sleep 2|g' Jenkinsfile
  ```
  淇敼鍚庯紝Cosign 浠呴渶 1 绉掑嵆鍙绾у畬鎴愬叕绉侀挜绛惧悕锛屽苟灏?OCI Signature 闄勪欢鎺ㄩ€佸埌 Harbor銆?
---

### 闂鍗佷節锛欰rgo CD ApplicationSet Controller 璁块棶鑷缓 GitLab 璇佷功闃绘柇锛坄server certificate verification failed`锛?
- **鐜拌薄**锛?  鎵ц `kubectl get applicationset -A` 鍙戠幇鐘舵€佸嚭鐜扮孩鑹茬殑 `ApplicationGenerationFromParamsError`锛?  ```text
  Error during fetching repo: `git fetch origin HEAD --tags --force --prune` failed exit status 128: fatal: unable to access 'https://gitlab.devops.example.com/root/camp-go-example-helm.git/': server certificate verification failed. CAfile: none CRLfile: none
  ```
  瀵艰嚧 Argo CD 鏃犳硶鑷姩鏍规嵁 Helm 浠撳簱鐜妯℃澘鍙戠幇 `dev` 涓?`main` 搴旂敤锛宍kubectl get applications -n argocd` 杩斿洖绌哄垪琛ㄣ€?- **鎺掓煡杩囩▼**锛?  1. 妫€鏌?`argocd/repo-secret.yaml`锛屽彂鐜板師瀹氫箟涓猴細
     ```yaml
     apiVersion: v1
     kind: Secret
     metadata:
       name: gitlab-repo-secret
       namespace: argocd
       labels:
         argocd.argoproj.io/secret-type: repo-creds
     stringData:
       type: git
       url: "https://gitlab.${domain}/root/camp-go-example-helm.git"
       password: ...
       username: root
     ```
  2. Argo CD 鐨?ApplicationSet Controller 涓?Repo Server 鍚屾牱杩愯鍦ㄧ嫭绔?Pod 涓紝鍐呴儴 git 瀹㈡埛绔粯璁や弗鏍兼牎楠岀洰鏍?GitLab 鐨?HTTPS 璇佷功锛?  3. 鐢变簬鑷缓 Ingress 璇佷功涓鸿嚜绛惧悕锛実it 鏍￠獙澶辫触锛屾嫆缁濇媺鍙?Helm 妯℃澘锛屽鑷?Application 鐢熸垚鍣ㄤ腑鏂€?- **鏍瑰洜鍒嗘瀽**锛?  Argo CD 浠撳簱鍑嵁鏈０鏄庤烦杩?TLS 鏍￠獙锛岀己灏?`insecure: "true"` 涓庢槑纭殑 `repository` 绫诲瀷鏍囩銆?- **瑙ｅ喅鏂规**锛?  鍦?`repo-secret.yaml` 涓鍔?`insecure: "true"` 骞跺湪 labels 涓厤缃负 `argocd.argoproj.io/secret-type: repository`锛?  ```yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: gitlab-repo-secret
    namespace: argocd
    labels:
      argocd.argoproj.io/secret-type: repository
  type: Opaque
  stringData:
    type: git
    url: "https://gitlab.${domain}/root/${example_project_name}-helm.git"
    password: ...
    username: root
    insecure: "true"
  ```
  鍦?`init.sh.tpl` 涓€氳繃 `yq` 杩涜鍥哄寲鏇存柊锛?  ```bash
  GITLAB_PERSONAL_TOKEN="$personal_access_token" yq -i '.stringData.url = "https://gitlab.${domain}/root/${example_project_name}-helm.git" | .stringData.password = strenv(GITLAB_PERSONAL_TOKEN) | .stringData.insecure = "true" | .metadata.labels."argocd.argoproj.io/secret-type" = "repository"' /tmp/repo-secret.yaml
  ```
  鏇存柊鍚庨噸鍚?Controller锛孉rgo CD 绔嬪嵆璇嗗埆鍒?`charts/env/*/values.yaml`锛岃嚜鍔ㄧ敓鎴?`dev` 鍜?`main` 涓や釜瀹屾暣 Application 骞惰嚜鍔ㄨ繘鍏ュ悓姝ャ€?
---

### 闂浜屽崄锛欿3s 鑺傜偣鎷夊彇鑷缓 Harbor 闀滃儚鎶?`ErrImagePull / x509: certificate is valid for ingress.local`

- **鐜拌薄**锛?  Argo CD 鍚屾鎴愬姛鍚庯紝K3s 鑺傜偣涓婄殑搴旂敤 Pod锛坄dev-podinfo`銆乣main-podinfo`锛夊嚭鐜?`ErrImagePull` / `ImagePullBackOff`锛?  ```text
  Failed to pull image "harbor.devops.example.com/example/camp-go-example:latest": failed to do request: Head "https://harbor.../v2/example/camp-go-example/manifests/latest": tls: failed to verify certificate: x509: certificate is valid for ingress.local, not harbor.devops.example.com
  ```
- **鎺掓煡杩囩▼**锛?  1. 搴旂敤浣跨敤鐨勯暅鍍忓湴鍧€涓?`harbor.devops.example.com/example/camp-go-example:latest`锛?  2. 璇ュ煙鍚嶈В鏋愬湪鑺傜偣鏈満 Ingress锛岃繑鍥炵殑璇佷功鏄?Ingress 榛樿璇佷功锛圴alid for `ingress.local`锛夛紱
  3. K3s 鍐呴儴杩愯鐨勫鍣ㄨ繍琛屾椂涓哄唴宓岀殑 `containerd`锛?  4. containerd 鍦ㄦ病鏈夋槑纭０鏄庡厑璁歌绉佹湁 Registry 蹇界暐 TLS 鏍￠獙鏃讹紝搴曞眰 Go crypto 搴撲弗鏍兼牎楠屽煙鍚嶅尮閰嶏紝鐩存帴鎷掔粷鎻℃墜鎷夊彇銆?- **鏍瑰洜鍒嗘瀽**锛?  K3s containerd 缂哄皯 `/etc/rancher/k3s/registries.yaml` 閰嶇疆鏂囦欢锛屾湭瀵规湰闆嗙兢鑷鍚?Harbor 鍩熷悕閰嶇疆 `insecure_skip_verify: true`銆?- **瑙ｅ喅鏂规**锛?  鍦?K3s 瀹夎鍓嶏紙鎴栧畨瑁呭悗锛夛紝鍒涘缓 `/etc/rancher/k3s/registries.yaml` 澹版槑璇?Harbor 闀滃儚浠撳簱蹇界暐璇佷功鏍￠獙锛?  ```yaml
  configs:
    "harbor.devops.example.com":
      tls:
        insecure_skip_verify: true
  ```
  骞跺湪 `init.sh.tpl` 鐨?`setup_k3s` 鍑芥暟鏈€鍓嶅垪鍥哄寲锛?  ```bash
  setup_k3s() {
      echo "Installing/starting K3s..."
      sudo mkdir -p /etc/rancher/k3s
      cat << EOF | sudo tee /etc/rancher/k3s/registries.yaml
  configs:
    "harbor.${domain}":
      tls:
        insecure_skip_verify: true
  EOF
      curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --tls-san ${public_ip} ...
  ```
  閰嶇疆鐢熸晥鍚庯紝K3s containerd 绉掔骇鎷夊彇闀滃儚骞跺惎鍔ㄥ鍣紝鎵€鏈夌幆澧?Pod 100% 杈炬垚 `1/1 Running`銆?
---

## 鍥涖€佹湇鍔¤闂笌鍏ㄦ爤缁勪欢楠屾敹鎸囧崡

閮ㄧ讲瀹屾垚鍚庯紝Terraform 灏嗚緭鍑哄叕缃?IP 涓庣櫥褰曞瘑鐮併€?
### 4.1 鑺傜偣缃戠粶涓?Hosts 鏄犲皠閰嶇疆

褰撳墠瀹炴垬闆嗙兢鍒嗛厤鐨勫熀纭€鍏綉 IP 淇℃伅濡備笅锛?*100% 绔炰环瀹炰緥 SPOTPAID**锛夛細
- **K3s 闆嗙兢涓昏妭鐐癸紙鍚?Ingress Controller锛?*锛歚43.135.123.232`锛堟満鍨嬶細`S6.4XLARGE32`锛岀珵浠峰疄渚嬶級
- **PostgreSQL 鏁版嵁搴撹妭鐐?*锛歚101.32.7.109`锛堟満鍨嬶細`S5.MEDIUM2`锛岀珵浠峰疄渚嬶級

鑻ュ湪鏈湴娴嬭瘯鏈В鏋愮殑绉佹湁娴嬭瘯鍩熷悕锛岃鍦ㄦ湰鍦版搷浣滅郴缁?Hosts 鏂囦欢涓坊鍔犲涓嬭В鏋愶細
```text
43.135.123.232 dev.podinfo.local
43.135.123.232 main.podinfo.local
```

> **缃戠粶閬垮潙鎻愮ず**锛氳嫢鏈湴瀹㈡埛绔紑鍚簡 VPN 鎴栦唬鐞嗗伐鍏凤紙濡?Clash銆乂2Ray 绛夛級锛岃姹傝嚜瀹氫箟鍩熷悕鏃惰嫢閬亣瓒呮椂鎴?000 鐘舵€佺爜锛岃鍦ㄥ懡浠よ涓檮鍔?`--noproxy "*"` 鍙傛暟缁曡繃鏈湴浠ｇ悊鐩存帴杩炴帴銆?
### 4.2 鍚勬牳蹇冨钩鍙拌闂竻鍗曚笌鐪熷疄璐﹀瘑

| 骞冲彴缁勪欢 | 璁块棶鍗忚涓庡湴鍧€ | 榛樿鐢ㄦ埛鍚?| 榛樿瀵嗙爜 / 鐪熷疄鍑嵁 | 瀹炴祴鍋ュ悍鐘舵€?|
| :--- | :--- | :--- | :--- | :--- |
| **GitLab** | `https://gitlab.devops.example.com` | `root` | `YOUR_GITLAB_PASSWORD`<br>*(PAT: `YOUR_GITLAB_PAT`)* | **HTTP 302** (姝ｅ父閲嶅畾鍚戣嚦鐧诲綍椤? |
| **Harbor** | `https://harbor.devops.example.com` | `admin` | `Harbor12345` | **HTTP 200** (API 涓?Web 鐣岄潰瀹屽叏姝ｅ父) |
| **Jenkins** | `http://jenkins.devops.example.com` | `admin` | `password123` | **HTTP 200** (JCasC 娴佹按绾垮凡鎴愬姛杞藉叆) |
| **SonarQube**| `http://sonar.devops.example.com` | `admin` | `password123` | **HTTP 200** (鏍稿績鐘舵€?`UP`) |
| **Argo CD**  | `http://argocd.devops.example.com` | `admin` | `password123` | **HTTP 200** (JWT Session 绛惧彂姝ｅ父) |
| **Grafana**  | `http://grafana.devops.example.com` | `admin` | `password123` | **HTTP 302** (姝ｅ父閲嶅畾鍚戣嚦鐧诲綍椤? |
| **Prometheus**| `http://prometheus.devops.example.com`| *(鏃犻渶鐧诲綍)* | *(鏃犻渶瀵嗙爜)* | **HTTP 302** (Active Targets: 23/23 姝ｅ父) |

### 4.3 闆嗙兢鍋ュ悍搴﹀叏璨岄獙璇佺粨鏋?
鎵ц `kubectl get pods -A`锛岄泦缇ゅ叏鍛藉悕绌洪棿 Pod 杩愯鍋ュ悍搴﹁揪鍒?**100%**锛?
```text
NAMESPACE     NAME                                                        READY   STATUS      RESTARTS      AGE
argocd        argocd-application-controller-0                             1/1     Running     0             12m
argocd        argocd-applicationset-controller-6868c9d4f5-fntqd           1/1     Running     0             12m
argocd        argocd-dex-server-785484b84c-2dtrs                          1/1     Running     0             12m
argocd        argocd-image-updater-8479d47fb7-jzjk5                       1/1     Running     0             11m
argocd        argocd-notifications-controller-68fcdd85c7-52kc9            1/1     Running     0             12m
argocd        argocd-redis-869cf94948-dh669                               1/1     Running     0             12m
argocd        argocd-repo-server-7587679464-jvz54                         1/1     Running     0             12m
argocd        argocd-server-55d545fc95-ctl2g                              1/1     Running     0             12m
gitlab        gitlab-certmanager-66976b6b45-vtlxt                         1/1     Running     0             35m
gitlab        gitlab-certmanager-cainjector-6fcc6d45f4-4fmfd              1/1     Running     0             35m
gitlab        gitlab-certmanager-webhook-6d6fb6fdc6-k4v69                 1/1     Running     0             35m
gitlab        gitlab-gitaly-0                                             1/1     Running     0             35m
gitlab        gitlab-gitlab-exporter-798684588f-5pw7x                     1/1     Running     0             35m
gitlab        gitlab-gitlab-runner-bdddf5df8-z7966                        1/1     Running     1 (32m ago)   35m
gitlab        gitlab-gitlab-shell-6c79b86f84-5g2k4                        1/1     Running     0             35m
gitlab        gitlab-gitlab-shell-6c79b86f84-l7tbb                        1/1     Running     0             35m
gitlab        gitlab-issuer-1-hhhzv                                       0/1     Completed   0             35m
gitlab        gitlab-kas-d4c6c95d7-jdwnb                                  1/1     Running     0             35m
gitlab        gitlab-kas-d4c6c95d7-zxfvb                                  1/1     Running     0             35m
gitlab        gitlab-migrations-1-kwnb4                                   0/1     Completed   0             35m
gitlab        gitlab-minio-598bf658b5-brlml                               1/1     Running     0             31m
gitlab        gitlab-nginx-ingress-controller-548c648d66-glgkf            1/1     Running     0             35m
gitlab        gitlab-nginx-ingress-controller-548c648d66-s9wfk            1/1     Running     0             35m
gitlab        gitlab-postgresql-0                                         2/2     Running     0             35m
gitlab        gitlab-prometheus-server-854bf6c5b-p288k                    2/2     Running     0             35m
gitlab        gitlab-redis-master-0                                       2/2     Running     0             35m
gitlab        gitlab-registry-7956ddf447-4j9j7                            1/1     Running     0             35m
gitlab        gitlab-registry-7956ddf447-pml9q                            1/1     Running     0             35m
gitlab        gitlab-sidekiq-all-in-1-v2-7d95958c97-vf8cd                 1/1     Running     0             35m
gitlab        gitlab-toolbox-5886d76794-2htqm                             1/1     Running     0             35m
gitlab        gitlab-webservice-default-6478ccb68d-sb4g8                  2/2     Running     0             35m
gitlab        gitlab-webservice-default-6478ccb68d-xdmvz                  2/2     Running     0             35m
harbor        harbor-core-7848787587-pcbft                                1/1     Running     2 (29m ago)   31m
harbor        harbor-database-0                                           1/1     Running     0             31m
harbor        harbor-exporter-788cb75465-gptnl                            1/1     Running     0             31m
harbor        harbor-jobservice-66b54ff6cf-j745m                          1/1     Running     5 (29m ago)   31m
harbor        harbor-portal-75b78564bd-9xnxl                              1/1     Running     0             31m
harbor        harbor-redis-0                                              1/1     Running     0             31m
harbor        harbor-registry-79b4d876c8-xf8w4                            2/2     Running     0             31m
harbor        harbor-trivy-0                                              1/1     Running     0             31m
jenkins       jenkins-0                                                   2/2     Running     0             10m
kube-system   coredns-54996dc9b4-nk5wh                                    1/1     Running     0             38m
kube-system   local-path-provisioner-77b9867795-5w5tf                     1/1     Running     0             38m
kube-system   metrics-server-6dc596dfb8-rp4rz                             1/1     Running     0             38m
kube-system   svclb-gitlab-nginx-ingress-controller-77cb352c-2d2dw        3/3     Running     0             35m
monitoring    alertmanager-kube-prometheus-stack-alertmanager-0           2/2     Running     0             37m
monitoring    kube-prometheus-stack-grafana-56666744d5-vmwgm              3/3     Running     1 (36m ago)   37m
monitoring    kube-prometheus-stack-kube-state-metrics-687686d88b-psdq4   1/1     Running     0             37m
monitoring    kube-prometheus-stack-operator-6c77d57994-9jhrm             1/1     Running     0             37m
monitoring    kube-prometheus-stack-prometheus-node-exporter-zz64n        1/1     Running     0             37m
monitoring    loki-0                                                      1/1     Running     0             37m
monitoring    loki-promtail-dk75w                                         1/1     Running     0             37m
monitoring    prometheus-kube-prometheus-stack-prometheus-0               2/2     Running     0             37m
sonarqube     sonarqube-postgresql-0                                      1/1     Running     0             16m
sonarqube     sonarqube-sonarqube-0                                       1/1     Running     0             27m
sonarqube     sonarqube-sonarqube-change-admin-password-hook-9v9fw        0/1     Completed   0             27m
```

---

## 浜斻€佺幆澧冩竻鐞嗕笌璧勬簮閿€姣?
瀹為獙鎴栨紨绀哄畬鎴愬悗锛屽姟蹇呭強鏃堕攢姣佷簯璧勬簮浠ラ伩鍏嶄骇鐢熶笉蹇呰鐨勬寔缁墸璐癸細

```bash
terraform destroy -auto-approve
```

璇ュ懡浠ゅ皢鍏ㄨ嚜鍔ㄦ竻鐞嗭細
1. 鑵捐浜戜笂鐨?2 鍙?CVM 浜戞湇鍔″櫒銆? 濂?VPC 铏氭嫙绉佹湁缃戠粶銆佸瓙缃戜笌瀹夊叏缁勮鍒欙紱
2. Cloudflare 涓婅嚜鍔ㄧ敓鎴愮殑 7 鏉″瓙鍩熷悕 A 璁板綍瑙ｆ瀽銆?
### 5.1 閿€姣侀伩鍧戜笌娉ㄦ剰浜嬮」
1. **闃茶緭鍏ユ墜璇?*锛氭敞鎰忔嫾鍐欎负 `destroy`锛堝嬁鏁叉垚 `destory`锛夈€?2. **渚濊禆閲婃斁绔炴€佸鐞嗭紙閲嶈锛?*锛?   - 鑵捐浜?CVM 瀹炰緥閿€姣佸悗锛屽脊鎬х綉鍗★紙ENI锛夊湪浜戝簳灞傚瓨鍦?10~30 绉掔殑寮傛娉ㄩ攢寤惰繜銆?   - 鑻ラ亣鍒?`ResourceInUse.SubnetNotEmpty` 鎴?`SecurityGroupInUse`锛?*鍒囧嬁鎵嬪姩鍦ㄦ帶鍒跺彴寮哄垹**锛岄潤寰?20 绉掑悗鍐嶆鎵ц鍚屼竴鍛戒护 `terraform destroy -auto-approve`锛孴erraform 浼氳嚜鍔ㄨ繘琛屽閲忓箓绛夋竻鐞嗐€?3. **褰诲簳閲婃斁楠岃瘉鏂规硶**锛?   鎵ц `terraform plan`锛岃嫢杈撳嚭锛?   ```text
   Plan: 29 to add, 0 to change, 0 to destroy.
   ```
   璇存槑浜戠鎵€鏈?29 涓璐?閰嶇疆璧勬簮宸?100% 褰诲簳娓呯┖锛屾棤浠讳綍鏆楁墸璐规畫鐣欍€?

---

## 鍏€佷紒涓氱骇 CI/CD 涓?GitOps 鍏ㄩ摼璺墦閫氶獙鏀跺疄褰?
鍏ㄥ浜戝師鐢?DevOps 娴佹按绾垮凡缁忓畬鏁磋窇閫氥€備互涓嬩负鍏ㄩ摼璺鍒扮闂幆楠岃瘉鐨勭湡瀹炴暟鎹笌鏍稿績璇佹嵁锛?
### 6.1 Jenkins CI 鑷姩鍖栨祦姘寸嚎锛圔uild #7锛夋墽琛屾垚鏋?
- **瑙﹀彂鏉ユ簮**锛欸itLab 婧愮爜浠撳簱 `main` 鍒嗘敮浠ｇ爜鎻愪氦锛圕ommit: `a8b9ba8`锛?- **鎬昏€楁椂**锛?40.7 绉掞紙绾?4 鍒嗛挓锛?- **鏋勫缓缁堟€?*锛歚SUCCESS`

#### 闃舵鎵ц鏃跺簭涓庤€楁椂鏄庣粏琛?
| 闃舵搴忓彿 | 娴佹按绾块樁娈靛悕绉?(Stage) | 鎵ц瀹瑰櫒 / 寮曟搸 | 鎵ц鐘舵€?| 鑰楁椂 (Duration) | 鏍稿績楠岃瘉鍐呭 |
| :---: | :--- | :--- | :---: | :---: | :--- |
| **Stage 1** | **Unit Test** | `golang:1.20-alpine` | **SUCCESS** | 41.1s | 鍗曞厓娴嬭瘯鍏ㄩ噺鎵ц锛屼唬鐮佽鐩栫巼妫€鏌ラ€氳繃 |
| **Stage 2** | **Scan Code with Sonarqube** | `sonar-scanner` | **SUCCESS** | 71.8s | 闈欐€佷唬鐮佸垎鏋愪笌璐ㄩ噺闂ㄧ锛圦uality Gate: OK锛夐€氳繃 |
| **Stage 3** | **Build with Kaniko** | `kaniko/executor` | **SUCCESS** | 86.7s | 鏃犻渶 Docker Daemon 瀹堟姢杩涚▼锛屽湪 K8s Pod 鍐呴儴瀹屾垚澶氶樁娈靛畨鍏ㄦ瀯寤猴紝杈撳嚭 `image.tar` |
| **Stage 4** | **Scan Image with Grype** | `anchore/grype` | **SUCCESS** | 15.4s | 瀹瑰櫒闀滃儚 CVE 婕忔礊瀹夊叏鎵弿閫氳繃锛堟棤 Critical 绾у埆闃绘柇锛?|
| **Stage 5** | **Crane Push Docker Image** | `crane/debug` | **SUCCESS** | 12.4s | 鍩轰簬 Google Crane 蹇€熷皢鏈湴 tar 闀滃儚鎺ㄩ€佸埌浼佷笟绾?Harbor 浠撳簱 |
| **Stage 6** | **Cosign Image** | `sigstore/cosign` + `crane` | **SUCCESS** | 12.5s | 浣跨敤闈炲绉扮閽ュ畬鎴愬鍣ㄧ鍚嶏紝鑷姩鎵撲笂 `latest` 鏍囩锛屽苟灏嗙鍚嶉檮浠舵帹閫佸埌 Harbor |

#### Jenkins 娴佹按绾块樁娈佃鍥炬帶鍒跺彴鎽樿

```text
Build ID: 7, Status: SUCCESS, Total Duration: 240.7s
  - Stage: Unit Test: SUCCESS (41.1s)
  - Stage: Scan Code with Sonarqube: SUCCESS (71.8s)
  - Stage: Build with Kaniko: SUCCESS (86.7s)
  - Stage: Scan Image with Grype: SUCCESS (15.4s)
  - Stage: Crane Push Docker Image: SUCCESS (12.4s)
  - Stage: Cosign Image: SUCCESS (12.5s)
Finished: SUCCESS
[GitLab Pipeline Status] Notifying branch build status: SUCCESS build-go-example/main #7: This commit looks good.
```

### 6.2 Harbor 闀滃儚鍒跺搧涓?Cosign 绛惧悕鐗╅獙璇?
鍦?Harbor 椤圭洰 `example/camp-go-example` 涓紝鏂伴暅鍍忓強鍏舵暟瀛楃鍚嶅埗鍝佸凡琚畬鏁存崟鑾凤細

```text
Artifact ID: 6
  Digest: sha256:0bcf9db35336db7315ce72832ae27ecfaa4a9c7e22847cb2cb0f80a06018c729
  Tags: ['latest', 'dev-a8b9ba8da22dce0834d7f9348354d64f8fd24b94', 'main-a8b9ba8da22dce0834d7f9348354d64f8fd24b94']
  Accessories: ['signature.cosign', 'signature.cosign']
  Type: IMAGE
```

Harbor 骞冲彴鍘熺敓璇嗗埆鍒颁簡 `signature.cosign` 绛惧悕闄勪欢锛屽苟鎵撲笂闃茬鏀逛俊浠诲畨鍏ㄦ爣璇嗐€?
### 6.3 Argo CD GitOps 鎸佺画浜や粯涓庡簲鐢ㄩ儴缃叉晥鏋?
Argo CD ApplicationSet Controller 鑷姩妫€娴嬪埌 `camp-go-example-helm` 浠撳簱鐨?`dev` 涓?`main` 閰嶇疆锛屽畬鎴愪簡鍏ㄨ嚜鍔ㄦ媺鍙栦笌闆嗙兢璧勬簮鍙戝竷锛?
```text
NAME              AGE
camp-go-example   ApplicationSet (Running)

NAME   SYNC STATUS   HEALTH STATUS
dev    Synced        Healthy
main   Synced        Healthy
```

鍦?Kubernetes 闆嗙兢鍛藉悕绌洪棿涓搴斾笟鍔℃湇鍔¤繍琛屽叏璨岋細

```text
NAMESPACE   NAME                                  READY   STATUS    RESTARTS   AGE
dev         dev-podinfo-678f5c8445-sbd5p          1/1     Running   0          5m
main        main-podinfo-c7544b76c-ttzvm          1/1     Running   0          5m
main        main-podinfo-redis-559c4fd877-g5cbp   1/1     Running   0          5m
```

### 6.4 涓氬姟鏈嶅姟 HTTP 璁块棶绔埌绔獙鏀剁粨鏋?
閫氳繃 Ingress Controller 楠岃瘉涓氬姟瀹為檯鍝嶅簲锛?
```bash
# 娴嬭瘯 Dev 寮€鍙戠幆澧?curl -s -H 'Host: dev.podinfo.local' http://127.0.0.1/
# 娴嬭瘯 Main 鐢熶骇鐜
curl -s -H 'Host: main.podinfo.local' http://127.0.0.1/
```

杩斿洖瀹為檯 JSON 杞借嵎锛?```json
{
  "hostname": "main-podinfo-c7544b76c-ttzvm",
  "version": "6.3.6",
  "color": "#34577c",
  "message": "greetings from podinfo v6.3.6",
  "goos": "linux",
  "goarch": "amd64",
  "runtime": "go1.20.14"
}
```

鑷虫锛屼簯鍘熺敓 DevOps 鍏ㄧ敓鍛藉懆鏈熼棴鐜嚜鍔ㄥ寲浣撶郴锛堝熀纭€璁炬柦浠ｇ爜鍖?IaC -> 鎸佺画闆嗘垚 CI -> 闀滃儚瀹夊叏渚涘簲閾?SecOps -> GitOps 鎸佺画浜や粯 CD锛夊叏閮ㄦ墦閫氾紝100% 楠屾敹閫氳繃锛?
