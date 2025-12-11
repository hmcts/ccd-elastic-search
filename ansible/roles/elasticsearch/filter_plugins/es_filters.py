# roles/elasticsearch/filter_plugins/es_filters.py


def aliases_to_actions(aliases, index):
    """
    Convert an aliases dict into a list of { "add": { "index": ..., "alias": ... } } actions.
    aliases is expected to be a dict like { "alias1": {}, "alias2": {} }
    """

    if not isinstance(aliases, dict):
        return []

    actions = []
    for alias_name in aliases.keys():
        actions.append({
            "add": {
                "index": index,
                "alias": alias_name,
            }
        })

    return actions


def filter_readonly_parts(index_def):
    """
    Remove read-only parts from index settings.
    """
    stripped = next(iter(index_def.values()))
    settings = stripped.get("settings", {})
    index = settings.get("index", {})
    index.pop("creation_date", None)
    index.pop("uuid", None)
    index.pop("version", None)
    index.pop("provided_name", None)
    index.pop("blocks", None)
    stripped.pop("aliases", None)
    return stripped


class FilterModule(object):
    def filters(self):
        # Map filter name in Ansible -> Python function
        return {
            "aliases_to_actions": aliases_to_actions,
            "filter_readonly_parts": filter_readonly_parts,
        }