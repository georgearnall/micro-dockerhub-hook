const { join: joinPath } = require('path')
const { promisify } = require('util')
const exec = promisify(require('child_process').exec)

module.exports = async (cmd, payload = { push_data: {}, repository: {} }) => {
  const path = joinPath(__dirname, '../scripts/').replace(/ /g,"\\\ ")
  const filePath = `${path}${cmd}`
  const env = Object.assign({}, process.env, {
    TAG: payload.push_data.tag,
    REPO_NAME: payload.repository.repo_name
  })

  try {
    const { stderr, stdout } = await exec(filePath, { env })
    return stderr || stdout
  } catch (e) {
    throw e.message
  }
}
