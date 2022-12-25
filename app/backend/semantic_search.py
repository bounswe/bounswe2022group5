import urllib

import requests


class SemanticSearchEngine(object):
    def __init__(self):
        super(SemanticSearchEngine, self).__init__()


    def get_descriptor(self, label):
        label_lookup_uri = f"https://id.nlm.nih.gov/mesh/lookup/descriptor?label={label}&match=exact&year=current&limit=1"
        try:
            response = requests.get(label_lookup_uri).json()[0]
        except:
            return None
        descriptor = response['resource'].split('/')[-1]
        return descriptor

    def get_broader_narrower_descriptor(self, descriptor):
        sparq_query = "PREFIX mesh: <http://id.nlm.nih.gov/mesh/> PREFIX meshv: <http://id.nlm.nih.gov/mesh/vocab#>  SELECT * FROM <http://id.nlm.nih.gov/mesh> WHERE {{  mesh:{descriptor} meshv:treeNumber ?tree_number .    {{     SELECT ?tree_number            ?broader_tree_number ?broader_descriptor            ?narrower_tree_number ?narrower_descriptor     WHERE {{       ?tree_number meshv:parentTreeNumber ?broader_tree_number .       ?broader_descriptor meshv:treeNumber ?broader_tree_number .       mesh:{descriptor} meshv:broaderDescriptor ?broader_descriptor .        ?narrower_tree_number meshv:parentTreeNumber ?tree_number .       ?narrower_descriptor meshv:treeNumber ?narrower_tree_number .       ?narrower_descriptor meshv:broaderDescriptor mesh:{descriptor} .     }}   }} }}"
        query = sparq_query.format(descriptor = descriptor)
        query = urllib.parse.quote(query)
        sparq_search_uri = f"https://id.nlm.nih.gov/mesh/sparql?query={query}"

        headers = {"accept": "application/sparql-results+json"}
        response = requests.get(sparq_search_uri, headers=headers)
        broader_descriptors = set()
        narrower_descriptors = set()
        results = response.json()['results']['bindings']

        for row in results:
            broader = row['broader_descriptor']['value'].split('/')[-1]
            narrower = row['narrower_descriptor']['value'].split('/')[-1]
            broader_descriptors.add(broader)
            narrower_descriptors.add(narrower)

        return broader_descriptors, narrower_descriptors

    def get_see_also(self, descriptor):
        uri = f"https://id.nlm.nih.gov/mesh/lookup/details?descriptor={descriptor}&includes=seealso"
        response = requests.get(uri)
        see_also_set = set()
        list = response.json()['seealso']
        for i in list:
            descriptor = i['resource'].split('/')[-1]
            see_also_set.add(descriptor)

        return see_also_set


    def get_labels(self, label):
        engine = SemanticSearchEngine()
        descriptor = engine.get_descriptor(label=label)
        if descriptor==None:
            return []
        general = []
        broader_descriptors, narrower_descriptors = engine.get_broader_narrower_descriptor(descriptor=descriptor)
        general.append(broader_descriptors)
        general.append(narrower_descriptors)
        related = engine.get_see_also(descriptor)
        general.append(related)

        two_iteration_broader_descriptors = set()
        two_iteration_narrower_descriptors = set()

        for descriptor in broader_descriptors:
            two_iteration_broader_descriptors, _ = engine.get_broader_narrower_descriptor(descriptor=descriptor)
            related_2_broadeer = engine.get_see_also(descriptor)
            general.append(two_iteration_broader_descriptors)
            general.append(related_2_broadeer)

        for descriptor in narrower_descriptors:
            _ , two_iteration_narrower_descriptors = engine.get_broader_narrower_descriptor(descriptor=descriptor)
            related_2_narrower = engine.get_see_also(descriptor)
            general.append(two_iteration_narrower_descriptors)
            general.append(related_2_narrower)

        last = set()
        for descriptor_set in general:
            for descriptor in descriptor_set:
                last.add(descriptor)

        labels = set()
        for i in last:
            label_uri = f"https://id.nlm.nih.gov/mesh/lookup/label?resource={i}"
            label = requests.get(label_uri).json()[0]
            labels.add(label)

        return labels


