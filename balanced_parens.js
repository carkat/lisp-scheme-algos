const isMatchedClosing = (code, stack) => stack.length &&
      stack[stack.length - 1] === String.fromCharCode(code - 1) ||
      stack[stack.length - 1] === String.fromCharCode(code - 2)

const isBalanced = (string, stack=[], open='({[') => !Boolean(
    string.split('').map(c => {
	const code = c.charCodeAt(0)
	return open.includes(c)             ? stack.push(c)
	    : isMatchedClosing(code, stack) ? stack.pop()
	    : false
    }).some(x => x === false) || stack.length)
