
require! {
	http
	fs
	path

	express
	canvas: Canvas
}

app = express!

space = new Canvas.Image!
space.src = fs.readFileSync \./assets/space.jpg

tori = new Canvas.Image!
tori.src = fs.readFileSync \./assets/tori.png

app.get \/, (req, res)-> 
	res.end '<a href=\"/space?num=20\">space doitsu no tori API</a>'

app.get \/space, (req, res)->

	params = 
		num: parseInt(req.query.num) or 3

	w = 960
	h = 630

	tori-w = 600
	tori-h = 750
	tori-scale = 6

	cvs = new Canvas w, h
	ctx = cvs.getContext \2d

	ctx.drawImage space, 0, 0

	[1 to params.num].forEach ->
		
		ctx.save!

		ctx.translate w / 2, h / 2
		ctx.rotate Math.random! * 360 * Math.PI / 180
		ctx.translate w / -2, h / -2

		ctx.drawImage tori, Math.random! * w .|. 0, Math.random! * h .|. 0, tori-w / tori-scale, tori-h / tori-scale

		ctx.restore!

	cvs.pngStream!.pipe res


server = http.createServer app

server.listen process.env.PORT or 3000
