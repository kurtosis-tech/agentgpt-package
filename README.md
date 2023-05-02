# agentGPT Package

Let your AI Agents loose locally in just 2 commands, made possible by [Kurtosis](https://github.com/kurtosis-tech/kurtosis)

Assuming you have Kurtosis [installed](https://docs.kurtosis.com/install/); replace _YOUR_API_KEY_HERE_ with your actual OpenAI API key

```bash
kurtosis run github.com/kurtosis-tech/agentgpt-package '{"OPENAI_API_KEY": "YOUR_API_KEY_HERE"}'
```

Then just visit it on your browser at `http://localhost:3000`

## Docker Image Note

Currently this project is working with a self published image at `h4ck3rk3y/agentgpt`. If you have the [`agentGPT`](https://github.com/reworkd/AgentGPT) repo cloned locally, do the following instead from inside the `agentGPT` repository:

```bash
./setup.sh --docker
kurtosis run github.com/kurtosis-tech/agentgpt-package '{"OPENAI_API_KEY": "YOUR_API_KEY_HERE", "IMAGE": "IMAGE_NAME"}'
```

Where `IMAGE_NAME` is the desired image name. The `IMAGE` arg overrides the `IMAGE` with which the container runs.


## Exposed Port Note

By default we expose the port `3000`; if you are running into port conflicts or want to change it for any other reason use the `PORT_OVERRIDE` arg; as follows (using 3030 as an example):

```bash
kurtosis run github.com/kurtosis-tech/agentgpt-package '{"OPENAI_API_KEY": "YOUR_API_KEY_HERE", "PORT_OVERRIDE": 3030}'
```
