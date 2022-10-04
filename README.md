<h1 dir="auto" style="text-align: center;">SETUP <a href="https://testnet.ollo.zone/">OLLO's</a> VALIDATOR NODE</h1>
<p dir="auto"><a title="Ollo" href="https://docs.ollo.zone/validators/create">Official guide</a></p>
<p dir="auto">Setup Ollo's Validator node by onecommand.</p>
<p dir="auto">You can edit the necessary variables, such as the <strong>port number</strong> to be replaced in the configuration files</p>
<ul>
<li><code><strong>wget -O https://raw.githubusercontent.com/whonion/OlloNode/main/OLLO.sh &amp;&amp; chmod +x OLLO.sh &amp;&amp; ./OLLO.sh</strong></code></li>
</ul>
<p style="text-align: left;">Setup with snapshot:</p>
<ul>
<li dir="auto"><code><strong>wget -O https://raw.githubusercontent.com/whonion/OlloNode/main/OlloSnap.sh &amp;&amp; chmod +x OLLO.sh &amp;&amp; ./OlloSnap.sh</strong></code></li>
</ul>
<p style="text-align: left;"><strong>Remove Ollo's node:</strong></p>
<p><code>sudo systemctl stop ollod &amp;&amp; \</code><br /><code>sudo systemctl disable ollod &amp;&amp; \</code><br /><code>sudo rm /etc/systemd/system/ollo* -rf &amp;&amp; \</code><br /><code>sudo rm $(which ollod) -rf &amp;&amp; \</code><br /><code>sudo rm $HOME/.ollo* -rf &amp;&amp; \</code><br /><code>sudo rm $HOME/ollo -rf &amp;&amp; \</code><br /><code>sed -i '/OLLO_/d' ~/.bash_profile</code></p>
