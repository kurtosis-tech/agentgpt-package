OPENAI_API_KEY_ENV_VAR = "OPENAI_API_KEY"

# WARNING DON'T USE IT IN PRODUCTION
# OVERRIDE THIS BY PASSING YOUR OWN NEXTAUTH_SECRET INSIDE ARGS
DEFAULT_NEXTAUTH_SECRET = "tcqlc6bKBaTiZ6KocEVoWJ3F5Q2IB9OAYWH/0OvrRck="

AGENTGPT_IMAGE = "agentgpt"

def run(plan, args):

    if  OPENAI_API_KEY_ENV_VAR not in args:
        fail("{0} is necessary to be passed".format(OPENAI_API_KEY_ENV_VAR))

    openai_api_key = args[OPENAI_API_KEY_ENV_VAR]

    env_vars = get_default_env(openai_api_key)
    
    for key in args:
        if key == OPENAI_API_KEY_ENV_VAR:
            continue
        plan.print("Overriding default value {0} with passed value {1} for {2}".format(env_vars[key], args[key], key))
        env_vars[key] = args[key]
    
    plan.add_service(
        name = "agentgpt",
        config = ServiceConfig(
            image = AGENTGPT_IMAGE,
            ports = {
                "http": PortSpec(number = 3000, transport_protocol = "TCP")
            },
            env_vars = env_vars
        )
    )



def validate_api_key(api_key):
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