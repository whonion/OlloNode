<h1 dir="auto" style="text-align: center;">SETUP OLLO's VALIDATOR NODE</h1>
<p dir="auto"><a title="Ollo" href="https://docs.ollo.zone/validators/create">Official guide</a></p>
<p dir="auto">Setup Ollo's Validator node by onecommand.</p>
<p dir="auto">You can edit the necessary variables, such as the port number to be replaced in the configuration files</p>
<ul>
<li dir="auto">wget -O https://raw.githubusercontent.com/whonion/OlloNode/main/OLLO.sh &amp;&amp; chmod +x OLLO.sh</li>
<li dir="auto">./OLLO.sh</li>
</ul>
<p>Remove Ollo's node:<br /><code>sudo systemctl stop ollod &amp;&amp; \</code><br /><code>sudo systemctl disable ollod &amp;&amp; \</code><br /><code>rm /etc/systemd/system/ollod.service &amp;&amp; \</code><br /><code>sudo systemctl daemon-reload &amp;&amp; \</code><br /><code>cd $HOME &amp;&amp; \</code><br /><code>rm -rf .ollo celestia-app &amp;&amp; \</code><br /><code>rm -rf $(which ollod)</code></p>
