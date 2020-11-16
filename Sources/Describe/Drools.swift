
public class Drools {
    
    public static let rules = [
        """
        rule "firewall"
            when
                $n: NetDevice($labels : labels contains "FIREWALL");
            then
                String cfg = ConfigGenerator.fromNode(
                    $n,
                    PolicyAction.BLOCK,
                    (NetId) netlabels.get("outside"),
                    (NetId) netlabels.get("campus network")
                );
                pusher.installRules(cfg);
        end
        """,
        """
        rule "firewall-exception"
        salience 10
            when
                $n: NetDevice($labels : labels contains "FIREWALL");
            then
                String cfg = ConfigGenerator.fromNode(
                    $n,
                    PolicyAction.ALLOW,
                    (NetId) netlabels.get("outside"),
                    (NetId) netlabels.get("campus network").plus(
                        (NetId) netlabels.get("web"))
                );
                pusher.installRules(cfg);
        end
        """,
        """
        rule "block insecure protocols"
        when
            $n: NetDevice();
        then
            String cfg = $n.generateConfig(
                    PolicyAction.BLOCK,
                    (NetId) netlabels.get("anywhere"),
                    (NetId) netlabels.get("telnet")
                );
                pusher.installRules(cfg);
            String pol = $n.generateConfig(
                    PolicyAction.BLOCK,
                    (NetId) netlabels.get("anywhere"),
                    (NetId) netlabels.get("ftp")
                );
                pusher.installRules(pol);
        end
        """,
        """
        rule "snort to qradar"
        when
            $n: Node($labels: labels contains "IDS");
            $q: EndSystem(alias == "qRadar");
        then
            // should return list of switches
            List<NetDevice> path = topo.computePath($n, $q);
            String pol = ConfigGen.pathConfig(path,
                 PolicyAction.ROUTE,
                 (NetId) netlabels.get("syslog"),
                 (NetId) netlabels.get("qradar"));
            pusher.installRules(pol);
        end
        """,
        """
        rule "printer network"
        when
            $p: EndSystem($labels: labels contains "PRINTER");
            $i: NetInterface(hostedBy == $p);
            $l: Link ( $i == src || == dst);
        then
            String cfg = ConfigGen.fromEndSystemLink($l,
                PolicyAction.BLOCK_TO_EXCEPT,
                (NetId) netlabels.get("anywhere"),
                (NetId) netlabels.get("Laserjet"),
                (NetId) netlabels.get("Laserjet").plus(
                    (NetId) netlabels.get("printer net")));
                pusher.installRules(cfg);
        end
        """,
        """
        rule "unnecesary services printer network"
        when
            $p: EndSystem($labels: labels contains "PRINTER");
            $i: NetInterface(hostedBy == $p);
            $l: Link ( $i == src || == dst);
        then
            String cfg = ConfigGen.fromEndSystemLink($l,
                PolicyAction.BLOCK,
                (NetId) netlabels.get("anywhere"),
                (NetId) netlabels.get("printer net").plus((NetId) netlabels.get("web")));
                pusher.installRules(cfg);
        end
        """,
        """
        rule "firewall-exception-ssh-to-h2"
            when
                $n: NetDevice($labels : labels contains "FIREWALL");
                        $m: EndSystem( alias == "H2")
            then
                String cfg = ConfigGenerator.fromNode(
                    $n,
                    PolicyAction.ALLOW,
                    (NetId) netlabels.get("outside"),
                    NetId.ipFromDevice($m).plus((NetId) netlabels.get("ssh"))
                );
                pusher.installRules(cfg);
        end
        """,
        """
        rule "firewall icmp"
            when
                $n: NetDevice($labels : labels contains "FIREWALL");
            then
                String cfg = ConfigGenerator.fromNode(
                    $n,
                    PolicyAction.BLOCK,
                    (NetId) netlabels.get("outside"),
                    (NetId) netlabels.get("icmp req")
                );
                pusher.installRules(cfg);
        end
        """,
        """
        rule "apple TV network"
        when
            $p: EndSystem($labels: labels contains "APPLE TV");
            $i: NetInterface(hostedBy == $p);
            $l: Link ( $i == src || $i == dst);
        then
            String cfg = ConfigGen.fromEndSystemLink($l,
                PolicyAction.BLOCK_TO_EXCEPT,
                (NetId) netlabels.get("anywhere"),
                (NetId) netlabels.get("bonjour"),
                (NetId) netlabels.get("bonjour").plus((NetId) netlabels.get("apple tv net")));
                pusher.installRules(cfg);
        end
        """,
        """
        rule "lab1 to snort"
        when
            $ids: Node($labels: labels contains "IDS");
            $h1: EndSystem(alias == "h1");
        then
            List<NetDevice> path = topo.computePath($ids, $h1);
            String pol = ConfigGen.pathConfig(path,
                 PolicyAction.ROUTE,
                 (NetId) netlabels.get("all"), (NetId) netlabels.get("all"));
            pusher.installRules(pol);
        end
        """
    ]
}
