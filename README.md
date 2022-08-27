# vpc-peering-test

VPCピアリングを利用して異なる2つのVPC間でプライベート接続を行う実験をします。

## プライベート接続の方法
```
# server1(パブリックサブネット内のEC2)にSSH接続を行う。
$ ssh <server1のパブリックIP>

# server2(他方のVPCに存在するプライベートサブネット内のEC2)にping要求を行い疎通を確認する。
$ ping <server2のプライベートIP>
> PING 172.16.1.209 (172.16.1.209) 56(84) bytes of data.
> 64 bytes from 172.16.1.209: icmp_seq=1 ttl=255 time=0.739 ms
> 64 bytes from 172.16.1.209: icmp_seq=2 ttl=255 time=0.652 ms
...
```

## Memo
VPCピアリングの設定後にルートテーブルの修正を忘れないこと。

## 参考
[VPC ピア接続を操作する](https://docs.aws.amazon.com/ja_jp/vpc/latest/peering/working-with-vpc-peering.html)
