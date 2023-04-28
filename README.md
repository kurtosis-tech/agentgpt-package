# agentGPT Package

"The quickest way to run or develop on AgentGPT", made possible by [Kurtosis](https://github.com/kurtosis-tech/kurtosis)

Assuming you have Kurtosis [installed](https://docs.kurtosis.com/install/); replace YOUR_API_KEY_HERE with the actual API key

```bash
kurtosis run github.com/kurtosis-tech/agentgpt-pacakge {"OPENAI_API_KEY": "YOUR_API_KEY_HERE"}
```

Then just visit it on your browser at `http://localhost:3000`

## Docker Image Note

Currently this project is working with a self published image at `h4ck3rk3y/agentgpt`. If you have the `agentGPT` repo cloned locally and want to use that; do the following instead from inside the `agentGPT` repository -

```bash
docker build -t IMAGE_NAME .
kurtosis run github.com/kurtosis-tech/agentgpt-pacakge {"OPENAI_API_KEY": "YOUR_API_KEY_HERE", "IMAGE": "IMAGE_NAME"}
```

Where `IMAGE_NAME` is the desired image name.