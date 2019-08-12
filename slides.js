const glob = require('fast-glob')

const asciidoctor = require('@asciidoctor/core')()
const kroki = require('asciidoctor-kroki')
const asciidoctorRevealjs = require('asciidoctor-reveal.js');

asciidoctorRevealjs.register()
kroki.register(asciidoctor.Extensions)

const options = {safe: 'unsafe', backend: 'revealjs', to_dir: './build/site/slides', attributes: {
	revealjsdir:  'https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.8.0',
}}

async function generateSlides () {
	const slides = await glob('slides/*')

	console.log(process.cwd())
	slides.map(slide => asciidoctor.convertFile(slide, options))

}

generateSlides()

