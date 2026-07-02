from django.test import SimpleTestCase
from django.urls import resolve


class ApiRoutingTests(SimpleTestCase):
    def test_root_url_redirects_to_swagger_docs(self):
        response = self.client.get('/')
        self.assertEqual(response.status_code, 302)
        self.assertEqual(response.url, '/api/docs/swagger/')
    def test_versioned_auth_routes_are_available(self):
        match = resolve('/api/v1/auth/register/')
        self.assertEqual(match.view_name, 'register')

    def test_versioned_jobs_routes_are_available(self):
        match = resolve('/api/v1/jobs/')
        self.assertEqual(match.view_name, 'get_jobs')

    def test_openapi_docs_endpoint_is_available(self):
        match = resolve('/api/docs/swagger/')
        self.assertEqual(match.view_name, 'schema-swagger-ui')
