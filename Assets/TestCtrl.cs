using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestCtrl : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 input = new Vector3(
            Input.GetAxisRaw("Horizontal"),
            0,
            Input.GetAxisRaw("Vertical")
        );

        Vector3 motion = input.normalized * .1f;
        Debug.Log(motion);
        //_ctrl.Move(motion * Time.deltaTime);
        transform.position += new Vector3(
            motion.x,
            0,
            motion.z
        );
    }
}
