import axios from 'axios'

global css
	html, body
		width: 100%
		height: 100%

	*
		margin: 0
		padding: 0

		box-sizing: border-box
		font-family: sans

tag app
	prop responses = []

	def mount
		setInterval(&, 1000 * 3) do
			const randomIndex = Math.round(Math.random() * 3 - 0.5)
			const method\'GET'|'DELETE'|'POST' = ['POST', 'PUT', 'DELETE'][randomIndex]

			const { data } = await axios({
				method: method
				url: 'http://localhost:3000/users'
			})

			const response = { 
				...data\any,
				method: method,
				timestamp: new Date()
			}
			
			self.responses = [response, ...self.responses]

			imba.commit()

	<self>
		<table>	
			<thead>
				<tr>
					<th> "Method"
					<th> "Before"
					<th> "After"
					<th> "Timestamp"
			<tbody>
				for response in responses
					<tr>
						<td.method.{response.method}> response.method
						<td.before>
							if response.before
								<pre> JSON.stringify(response.before, null, 2)
						<td.after>
							if response.after
								<pre> JSON.stringify(response.after, null, 2)
						<td.timestamp> response.timestamp.toISOString()

	css &
		width: 100%
		height: 100%

		margin: 2rem

		table
			border-spacing: initial

			tr
				& + tr
					td
						border-top: 1px solid gray1

				th, td
					padding: .5rem 1rem 
					
				th
					background: gray8
					color: white
					font-size: .875rem
					font-weight: 500
					text-transform: uppercase

					&@first-of-type
						border-top-left-radius: .5rem

					&@last-of-type
						border-top-right-radius: .5rem

				td
					&.method
						font-weight: 500
						text-align: center

						&.post
							color: green5

						&.put
							color: yellow5

						&.delete
							color: red5
					
					&.before, &.after
						pre
							background: gray1
							border-radius: .25rem
							color: gray8
							padding: .5rem 1rem
							font-family: monospace

					&.timestamp
						color: gray8
						font-size: .875rem
						text-align: center
						white-space: nowrap

imba.mount <app>
