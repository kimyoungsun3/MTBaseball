using System.Collections;
using System.Collections.Generic;
using UnityEngine;


//[RequireComponent(typeof(Rigidbody))]
namespace RigidbodyVelocityMove{
	public class RigidbodyVelocityMove : MonoBehaviour {
		Rigidbody rb;
		public float speed = 2f;
		// Use this for initialization
		void Start () {
			rb = GetComponent < Rigidbody> ();

			
		}
		
		// Update is called once per frame
		void Update () {
			float h = Input.GetAxisRaw ("Horizontal");
			float v = Input.GetAxis ("Vertical");

			Vector3 velocity = new Vector3 (h, 0, v);
			velocity = velocity.normalized;
			rb.velocity = velocity * speed;


		}
	}
}
