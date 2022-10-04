<h1 dir="auto" style="text-align: center;">SETUP <a href="https://testnet.ollo.zone/">OLLO's</a> VALIDATOR NODE</h1>
<p dir="auto"><a title="Ollo" href="https://docs.ollo.zone/validators/create">Official guide</a></p>
<p dir="auto"><strong>I Setup Ollo's Validator node by onecommand</strong>.</p>
<p dir="auto">You can edit the necessary variables, such as the <strong>port number</strong> to be replaced in the configuration files</p>
<ul>
<li><code><strong>wget -O https://raw.githubusercontent.com/whonion/OlloNode/main/OLLO.sh &amp;&amp; chmod +x OLLO.sh &amp;&amp; ./OLLO.sh</strong></code></li>
</ul>
<p style="text-align: left;">Setup with snapshot:</p>
<ul>
<li dir="auto"><code><strong>wget -O https://raw.githubusercontent.com/whonion/OlloNode/main/OlloSnap.sh &amp;&amp; chmod +x OLLO.sh &amp;&amp; ./OlloSnap.sh</strong></code></li>
</ul>
<p style="text-align: left;"><strong>II Add wallet and create validator:</strong></p>
<p><strong>#CREATE_WALLETS</strong></p>
<p><code>ollod keys add $OLLO_WALLET --recover &amp;&amp; \ OLLO_WALLET_ADDRESS=$(ollod keys show $OLLO_WALLET -a) &amp;&amp; \ OLLO_VALOPER_ADDRESS=$(ollod keys show $OLLO_WALLET --bech val -a) &amp;&amp; \ echo 'export OLLO_WALLET_ADDRESS='${OLLO_WALLET_ADDRESS} &gt;&gt; $HOME/.bash_profile &amp;&amp; \ echo 'export OLLO_VALOPER_ADDRESS='${OLLO_VALOPER_ADDRESS} &gt;&gt; $HOME/.bash_profile &amp;&amp; \ source $HOME/.bash_profile</code></p>
<p><strong>#CREATE_VALIDATOR AFTER SYNC</strong></p>
<code>
ollod tx staking create-validator \
  --amount 1999000utollo \
  --from $OLLO_WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(ollod tendermint show-validator) \
  --moniker $OLLO_NODENAME \
  --chain-id $OLLO_ID \
  --fees 250utollo
</code>
<p><strong># Remove Ollo's node:</strong></p>
<p><code>sudo systemctl stop ollod &amp;&amp; \</code><br /><code>sudo systemctl disable ollod &amp;&amp; \</code><br /><code>sudo rm /etc/systemd/system/ollo* -rf &amp;&amp; \</code><br /><code>sudo rm $(which ollod) -rf &amp;&amp; \</code><br /><code>sudo rm $HOME/.ollo* -rf &amp;&amp; \</code><br /><code>sudo rm $HOME/ollo -rf &amp;&amp; \</code><br /><code>sed -i '/OLLO_/d' ~/.bash_profile</code></p>
