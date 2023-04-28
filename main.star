OPENAI_API_KEY_ENV_VAR = "OPENAI_API_KEY"

# WARNING DON'T USE IT IN PRODUCTION
# OVERRIDE THIS BY PASSING YOUR OWN NEXTAUTH_SECRET INSIDE ARGS
DEFAULT_NEXTAUTH_SECRET = "tcqlc6bKBaTiZ6KocEVoWJ3F5Q2IB9OAYWH/0OvrRck="

DEFAULT_IMAGE = "h4ck3rk3y/agentgpt"
# Set args to {"IMAGE": "YOUR_IMAGE_HERE"} to pull a different image than h4ck3rk3y/agentgpt
IMAGE_OVERRIDE_KEY = "IMAGE"

DEFAULT_PORT_TO_EXPOSE = 3000
HTTP_PORT_ON_CONTAINER = 3000
# pass PORT_OVERRIDE arg key to expose the server on something else apart from 3000
PORT_OVERRIDE_ARG_KEY = "PORT_OVERRIDE"

# We don't validate this; we just let it go
TEST_API_KEY = "test"

def run(plan, args):

    if  OPENAI_API_KEY_ENV_VAR not in args:
        fail("{0} is necessary to be passed".format(OPENAI_API_KEY_ENV_VAR))

    openai_api_key = args[OPENAI_API_KEY_ENV_VAR]

    env_vars = get_default_env(openai_api_key)
    
    for key in args:
        if key == OPENAI_API_KEY_ENV_VAR or key not in env_vars:
            continue
        plan.print("Overriding default value {0} with passed value {1} for {2}".format(env_vars[key], args[key], key))
        env_vars[key] = args[key]

    exposed_port = args.get(PORT_OVERRIDE_ARG_KEY, DEFAULT_PORT_TO_EXPOSE)
    image = args.get(IMAGE_OVERRIDE_KEY, DEFAULT_IMAGE)
    
    plan.add_service(
        name = "agentgpt",
        config = ServiceConfig(
            image = image,
            ports = {
                "http": PortSpec(number = HTTP_PORT_ON_CONTAINER, transport_protocol = "TCP")
            },
            public_ports = {
                "http": PortSpec(number = exposed_port, transport_protocol = "TCP"),
            },
            env_vars = env_vars
        )
    )

    return {
        "agentGPT URL": "http://127.0.0.1:{0}".format(exposed_port)
    }


def validate_api_key(api_key):
    if api_key == TEST_API_KEY:
        return

    if len(api_key) != 51:
        fail("Invalid API Key; api keys must be 51 characters long and begin with sk-")
    
    if api_key[0:3] != "sk-":
        fail("Invalid API Key; api keys must be 51 characters long and begin with sk-")

    for character in api_key[3:]:
        if not character.isalnum():
            fail("Invalid API Key; api keys must be 51 characters long and begin with sk-. Characters after sk- can only be alphanumeric got {0}".format(character))


def get_default_env(openai_api_key):
    return {
        "NODE_ENV": "development",
        "NEXTAUTH_SECRET": DEFAULT_NEXTAUTH_SECRET,
        "NEXTAUTH_URL": "http://localhost:3000",
        "OPENAI_API_KEY": openai_api_key,
        "DATABASE_URL": "file:../db/db.sqlite",
    }