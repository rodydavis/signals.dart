import type { APIRoute } from "astro";
import { getCollection } from "astro:content";

// Fetch all documents from the 'docs' collection
const allDocs = await getCollection("docs");

// Extract the body (content) from each document
const posts = allDocs.map(doc => doc.body);

export const GET: APIRoute = async ({ request }) => {
    const url = new URL(request.url);
    const query = url.searchParams.get('q');

    let results = posts;

    if (query) {
        results = results.filter((item: string) => item.includes(query));
    }

    return new Response(results.join('\n\n---\n\n'), { 
        status: 200,
        headers: { "Content-Type": "text/plain; charset=utf-8" }
    });
};